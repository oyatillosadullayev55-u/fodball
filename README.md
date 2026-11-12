# ⚽ Fodball

Futbol klubi boshqaruv paneli — **Flutter** (Material 3) bilan yozilgan, to'liq responsiv dashboard.
Dizayn: dark navy fon, lime va gold aksentlar, maydon ustidagi o'yinchilar tarkibi.

![Fodball dashboard](docs/preview-desktop.png)

## Skrinshotlar

| Desktop — 1672×941 | Mobile — 414×896 |
| --- | --- |
| ![Desktop](docs/preview-desktop.png) | ![Mobile](docs/preview-mobile.png) |

## Imkoniyatlar

- **Profil paneli** — avatar, `Oyatillo_4349`, Level 28, XP progress, 128 o'yin / 92 g'alaba / 7 kubok
- **Navigatsiya** — `PLAY`, `TOURNAMENT`, `MY CLUB`, `STORE` (highlight holati bilan)
- **Jonli o'yin** — `RMA 0-0 15:24`, egalik foizi, "Watch match"
- **UCL EVENT banneri** — `CHAMPIONS!`, Real Madrid, `Play Now!`, `6d 12h 37m` countdown
- **Match control** — `Shoot` / `Pass` / `Sprint` + possession, shots, xG, passes statistikasi
- **My Team** — `4-3-3` maydoni (CustomPainter chiziqlari), 11 o'yinchi kartasi (reyting + pozitsiya), `Team Power 96.8`, Attack / Midfield / Goalkeeper barlari
- **Store** — Packs / Players / Coins tablari, Standard / Premium / Legendary paketlar, `-70%` Special Offer
- **Season progress** — Division 3, 1,840 / 2,500 pts, reward kartalari
- **Responsiv layout** — 3 ustun → 2 ustun → 1 ustun, overflow'siz

## Texnologiyalar

| | |
| --- | --- |
| Framework | Flutter 3.47 (Dart 3.13) |
| UI | Material 3, custom `GlassCard`, `Pill`, `StatBar`, `PitchPainter` |
| Paketlar | faqat Flutter SDK (tashqi dependency yo'q) |
| Platformalar | Android, iOS, Web |

## Ishga tushirish

### Android Studio

1. **File → Open** → `fodball` papkasini tanlang.
2. Flutter SDK sozlangan bo'lishi kerak (**Settings → Languages & Frameworks → Flutter**).
3. Yuqori o'ng burchakda qurilma tanlang (telefon yoki emulyator).
4. **Run** (`Shift + F10`) — `main.dart` run configuration tayyor.

> Qurilma ko'rinmasa: telefonni USB bilan ulang, **USB debugging** ni yoqing va telefonda **Allow** bosing.
> Tekshirish: `flutter devices`.

### Terminal

```bash
flutter pub get
flutter run                # ulangan qurilma
flutter run -d chrome      # brauzer
```

### APK

```bash
flutter build apk --release
# build/app/outputs/flutter-apk/app-release.apk
```

## Tuzilma

```
lib/
├─ main.dart                      # kirish nuqtasi
├─ theme/
│  ├─ app_colors.dart             # rang palitrasi
│  └─ app_theme.dart              # Material 3 temasi
├─ models/models.dart             # Player, MenuEntry, Pack
├─ data/mock_data.dart            # demo ma'lumotlar
├─ screens/dashboard_screen.dart  # responsiv layout
└─ widgets/
   ├─ common.dart                 # GlassCard, Pill, StatBar, PitchPainter...
   ├─ top_bar.dart                # profil, valyutalar, bo'limlar
   ├─ side_panel.dart             # profil, menyu, jonli o'yin, iqtibos
   ├─ hero_card.dart              # CHAMPIONS! / UCL EVENT
   ├─ match_control_card.dart     # Shoot / Pass / Sprint
   ├─ team_panel.dart             # maydon, o'yinchilar, Team Power
   └─ store_panel.dart            # paketlar, Special Offer
```

## Responsivlik

| Kenglik | Layout |
| --- | --- |
| `≥ 1180 px` | 3 ustun: sidebar + markaz + jamoa/do'kon |
| `≥ 860 px` | 2 ustun: sidebar + kontent |
| `< 860 px` | 1 ustun (telefon) |

## Sifat nazorati

```bash
flutter analyze   # 0 issue
flutter test      # 8 test: 1920→360 px gacha overflow tekshiruvi
```

## Dizayn hujjati

Batafsil spetsifikatsiya: [`docs/DESIGN.md`](docs/DESIGN.md)

---

Flutter bilan ❤️ bilan yozilgan.
