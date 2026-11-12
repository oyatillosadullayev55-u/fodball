# Fodball — dizayn spetsifikatsiyasi

Manba: `fodball.png` (1672×941) — futbol o'yini klub dashboardi.

## 1. Umumiy g'oya

Bir ekranda o'yinchining holati, joriy o'yin, jamoa tarkibi va do'kon.
Layout uch ustunga bo'lingan:

```
┌──────────────┬──────────────────────────────┬────────────────────┐
│  Sidebar     │  Markaz                      │  Jamoa + Do'kon    │
│  (300 px)    │  (flex)                      │  (440 px)          │
│              │                              │                    │
│  Profil      │  CHAMPIONS! hero             │  My Team           │
│  Menyu       │  Match control               │   ├─ 4-3-3 pitch   │
│  Live match  │  Season progress             │   └─ Team Power    │
│  Iqtibos     │                              │  Store             │
│              │                              │  Special Offer     │
└──────────────┴──────────────────────────────┴────────────────────┘
```

## 2. Rang palitrasi

| Token | HEX | Qo'llanishi |
| --- | --- | --- |
| `bg` | `#050A16` | asosiy fon |
| `bgDeep` | `#02050C` | gradient oxiri |
| `surface` | `#0B1426` | kartalar |
| `surfaceAlt` | `#111E38` | ichki bloklar, chip'lar |
| `stroke` | `#1C2A47` | ramkalar |
| `lime` | `#C8FF4D` | asosiy aksent, CTA |
| `gold` | `#FFC542` | tangalar, Special Offer |
| `red` | `#FF4D5E` | LIVE, Attack |
| `blue` | `#4D7CFF` | Midfield, FCB |
| `pitch` | `#0F3B24` | maydon |
| `muted` | `#8794B4` | ikkinchi darajali matn |

## 3. Tipografiya

- Sarlavhalar: `w900`, harflar orasi `-1.2` (CHAMPIONS!, Team Power)
- Bo'lim nomlari: `12 px`, `w800`, `letterSpacing: 1.4`, UPPERCASE
- Matn: `13 px`, `height: 1.35`
- Yorliqlar: `10 px`, `w700`, `letterSpacing: 1.1`

## 4. Komponentlar

### GlassCard
`radius 22`, gradient yoki `surface` fon, `strokeSoft` ramka, yumshoq soya.

### Pill
Dumaloq yorliq: LIVE, LEVEL 28, 4-3-3, -70%, +4.2.

### PlayerChip
- 32 px dumaloq avatar (bosh harflar, klub rangida gradient)
- yuqori o'ngda reyting badge (`lime` fon, `bgDeep` matn)
- pastda pozitsiya (`GK`, `CB`, `CM`, `ST`...)
- ostida o'yinchi ismi

### PitchPainter
`CustomPainter`: tashqi ramka, markaziy chiziq, markaziy doira, penalti va darvoza maydonchalari.

## 5. Bo'limlar bo'yicha kontent

| Bo'lim | Kontent |
| --- | --- |
| Top bar | avatar, `Oyatillo_4349`, LEVEL 28, 8,750 tanga, 120 gem, Players / Upgrades / Tactics |
| Profil | XP 6,240 / 9,000, 128 matches, 92 wins, 7 trophies |
| Menyu | PLAY — Start a Match, TOURNAMENT — Win Trophies, MY CLUB — Build Your Team, STORE — Get Rewards |
| Live match | RMA 0-0 FCB, 15:24, possession 58% / 42% |
| Hero | UCL EVENT, 6d 12h 37m, CHAMPIONS!, Real Madrid, Play Now!, Continue |
| Match control | Shoot, Pass, Sprint; 58% possession, 7 shots, 1.84 xG, 89% passes |
| My Team | 4-3-3: Alisson 96, Hernández 93, van Dijk 94, Rüdiger 95, Hakimi 93, Pedri 95, Bellingham 95, De Bruyne 96, Vinicius Jr. 97, Mbappé 97, Salah 98 |
| Team Power | 96.8, Top 4%, Attack 96 / Midfield 95 / Goalkeeper 96 |
| Store | Standard 100,000 — Premium 500 — Legendary 1,000; 8,750 coins |
| Special Offer | -70%, $4.99 (eski $16.63), Legendary Pack + 2,500 coins + rare kit |
| Season | Division 3, 1,840 / 2,500 pts, #1,204 |

## 6. Responsiv qoidalar

- `≥ 1180 px` — uch ustun, jamoa kartasi ichida pitch va statistika yonma-yon
- `860–1180 px` — sidebar + bitta keng ustun (markaz, jamoa, do'kon ketma-ket)
- `< 860 px` — hamma bloklar bitta ustunda, pitch ustida statistika pastda
- Barcha matnlar `ellipsis` yoki `FittedBox` bilan himoyalangan — 360 px gacha overflow yo'q

## 7. Keyingi qadamlar

- [ ] Real API / state management (Riverpod yoki Bloc)
- [ ] O'yinchi rasmlari (asset yoki network image + keshlash)
- [ ] Animatsiyalar: countdown, rating badge, pitch hover
- [ ] Dark / light tema
- [ ] Lokalizatsiya (uz / en / ru)
