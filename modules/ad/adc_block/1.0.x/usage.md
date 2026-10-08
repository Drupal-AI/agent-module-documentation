<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Analog Digital Clock (ADC Block) provides configurable real-time analog and digital clock blocks, rendered with Canvas, CSS/HTML and SVG.

---

The module ships four core Block plugins — a Canvas analog clock (`adc_block_block`), a CSS/HTML digital clock (`adc_block_digital_block`), and two fully custom SVG variants (`svg_clock_analog_dynamic`, `svg_clock_digital_dynamic`). Site builders place them through **Structure → Block layout** and configure each instance's styling in the block form: face/hand/tick/number/text colors, hand and tick widths and lengths, borders, shadows and glow effects, font family/size/weight, and (for digital blocks) date/day display with selectable or custom PHP date formats. Time is resolved and ticked entirely client-side in attached JavaScript, so the blocks are uncacheable (`getCacheMaxAge()` returns 0). Timezone can follow the site/system timezone, the visitor's local browser timezone, or a specific named timezone. The analog `adc_block_block` also offers ten numbered preset layouts plus a Custom mode. Templates for all four blocks are overridable in a theme. The module has no routes, permissions, services, external APIs, or non-core dependencies — it needs only Drupal core 9/10/11 and the core Block module.

---

- Place a real-time analog clock in a sidebar or header region.
- Place a digital clock with a live-updating time display.
- Show a high-fidelity SVG analog clock that scales cleanly on retina/high-density screens.
- Show a fully styled SVG digital clock with date and day of week.
- Pick one of ten preset analog layouts (dark, transparent, blue, red-accent, etc.) for quick setup.
- Fully customize an analog clock's fill, border, pin, hand and tick colors.
- Set hour/minute/second hand widths and lengths independently.
- Toggle and color major and minor tick marks, or make them transparent.
- Add a drop shadow or glow effect to a clock face.
- Display a clock in a specific timezone (e.g. America/New_York, Europe/London).
- Display time in the visitor's local browser timezone.
- Follow the site's system/default timezone automatically.
- Show today's date under a digital clock using a Drupal date format.
- Use a custom PHP date format string for the digital date line.
- Add an optional heading above and footer below an analog clock.
- Add an optional description line under a digital clock.
- Choose a 12-hour or 24-hour time format on the SVG digital clock.
- Show or hide seconds, date and day of week on the SVG digital clock.
- Set font family, size, weight and letter spacing for the digital display.
- Apply container background, border radius, border style and box-shadow to the digital clock.
- Style hour numbers as Arabic, Roman, or dots-only on the SVG analog clock.
- Add a gradient (linear or radial) background to an SVG clock face.
- Override any clock template by copying the Twig file into your theme.
- Deploy multiple clocks with different timezones side by side (e.g. a world-clock wall).
- Restyle clocks site-wide with custom CSS targeting the block wrappers.
