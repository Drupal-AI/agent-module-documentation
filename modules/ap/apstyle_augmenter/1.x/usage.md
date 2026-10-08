<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Associated Press Stylebook Augmenter provides a Date Augmenter plugin that rewrites date and time output to follow Associated Press (AP) Stylebook conventions.

---

The module ships one Date Augmenter plugin (`apstyle`, "Associated Press Stylebook") that plugs into the Date Augmenter API. Rather than being its own field formatter, it augments the render array produced by a compatible date formatter — such as Smart Date — after the date has been rendered, applying three independent, individually toggleable rules: lowercasing meridians and adding periods (a.m./p.m.), expanding short month abbreviations to full names while abbreviating September as "Sept.", and replacing 12 a.m./12 p.m. with the words "noon" and "midnight". All three rules are on by default so output is AP-compliant out of the box, but each can be disabled per formatter instance on the field's Manage display form. The project also bundles an optional Smart Date format (`ap_stylebook`) tuned to produce AP-friendly output when Smart Date is installed.

---

- Make date field output conform to AP Stylebook style automatically.
- Convert `AM`/`PM` and `am`/`pm` meridians to `a.m.`/`p.m.` with periods and lowercase letters.
- Expand short month abbreviations (e.g. `Mar` to `March`, `June`, `July`) per AP rules.
- Abbreviate September specifically as `Sept.` per AP convention.
- Keep AP's short-month abbreviations (`Jan.`, `Feb.`, `Aug.`, `Oct.`, `Nov.`, `Dec.`) as-is.
- Replace `12 p.m.` / `12:00 pm` with the word "noon" in rendered output.
- Replace `12 a.m.` / `12:00 am` with the word "midnight" in rendered output.
- Handle date ranges where the start time is bare (`12`) and the meridian comes from the end time.
- Style editorial and news content dates consistently across a site.
- Apply AP style to Smart Date range fields on the entity display.
- Enable AP styling per field display without changing the underlying stored date value.
- Disable the meridian rule while keeping month expansion, or any other combination.
- Use the bundled `ap_stylebook` Smart Date format for AP-compliant date/time output.
- Pair with the Smart Date module's formatter for the recommended experience.
- Layer AP style on top of any Date Augmenter-compatible formatter.
- Standardize press-release and article date formatting.
- Adjust output at display time only — no cron, no stored data changes.
- Turn styling on for a newsroom content type and leave it off elsewhere.
- Keep default rules for a quick AP-compliant setup with zero configuration.
- Review output after enabling to confirm it matches your target AP stylebook edition.
