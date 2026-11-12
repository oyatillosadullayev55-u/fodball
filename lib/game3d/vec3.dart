import 'dart:math' as math;
import 'dart:ui';

/// Oddiy 3D vektor.
class V3 {
  const V3(this.x, this.y, this.z);

  final double x;
  final double y;
  final double z;

  static const zero = V3(0, 0, 0);

  V3 operator +(V3 o) => V3(x + o.x, y + o.y, z + o.z);
  V3 operator -(V3 o) => V3(x - o.x, y - o.y, z - o.z);
  V3 operator *(double s) => V3(x * s, y * s, z * s);
  V3 operator -() => V3(-x, -y, -z);

  double dot(V3 o) => x * o.x + y * o.y + z * o.z;

  V3 cross(V3 o) =>
      V3(y * o.z - z * o.y, z * o.x - x * o.z, x * o.y - y * o.x);

  double get length => math.sqrt(dot(this));

  V3 get normalized {
    final l = length;
    return l == 0 ? zero : this * (1 / l);
  }

  V3 lerp(V3 o, double t) => this + (o - this) * t;

  @override
  String toString() =>
      'V3(${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)}, ${z.toStringAsFixed(2)})';
}

/// Perspektiv kamera: ko'z nuqtasi, qarash nuqtasi va vertikal ko'rish burchagi.
class Camera3D {
  Camera3D({required this.eye, required this.target, this.fovY = 0.92});

  final V3 eye;
  final V3 target;
  final double fovY;

  late final V3 forward = (target - eye).normalized;
  late final V3 right = const V3(0, 1, 0).cross(forward).normalized;
  late final V3 up = forward.cross(right).normalized;
}

/// 3D nuqtani ekranga proyeksiya qiluvchi va teskarisini hisoblovchi vosita.
class Projector {
  Projector(this.camera, this.size)
      : focal = size.height / (2 * math.tan(camera.fovY / 2));

  final Camera3D camera;
  final Size size;
  final double focal;

  /// Nuqta kamera orqasida bo'lsa `null` qaytadi.
  Offset? project(V3 p) {
    final d = p - camera.eye;
    final cz = d.dot(camera.forward);
    if (cz <= 0.05) return null;
    final cx = d.dot(camera.right);
    final cy = d.dot(camera.up);
    return Offset(
      size.width / 2 + cx / cz * focal,
      size.height / 2 - cy / cz * focal,
    );
  }

  double depthOf(V3 p) => (p - camera.eye).dot(camera.forward);

  /// Berilgan nuqtadagi masshtab: 1 metr necha piksel.
  double scaleAt(V3 p) {
    final cz = depthOf(p);
    return cz <= 0.05 ? 0 : focal / cz;
  }

  /// Ekran nuqtasidan `z = planeZ` tekisligidagi 3D nuqtaga nur tashlash.
  V3 unproject(Offset screen, double planeZ) {
    final dx = (screen.dx - size.width / 2) / focal;
    final dy = -(screen.dy - size.height / 2) / focal;
    final dir = camera.right * dx + camera.up * dy + camera.forward;
    if (dir.z.abs() < 0.0001) return V3(0, 0, planeZ);
    final t = (planeZ - camera.eye.z) / dir.z;
    return camera.eye + dir * t;
  }
}
