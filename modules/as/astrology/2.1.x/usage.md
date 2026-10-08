<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Astrology lets editors author daily, weekly, monthly and yearly horoscope text for zodiac (or custom) star signs and shows it to visitors in a block and on public pages.

---

Astrology ships a default **"Zodiac"** astrology with the twelve signs (Aries…Pisces), each with a date range, icon and description, stored in three custom database tables. Administrators add **horoscope text per sign and per period** (day / week / month / year) through admin forms under **Configuration → Astrology**; the module then renders that text on public pages (`/astrology/{sign}/{format}/{n}`) with previous/next navigation, a per-sign details page, and a **date-of-birth form** that maps a visitor's birthday to their sun sign. A block plugin named **"Astrology"** lists the signs and links to their horoscope pages. You can create additional named astrologies beyond Zodiac and pick which one is the site-wide default, plus the default display format, from the settings form. All content lives locally in the site database — there is no external horoscope feed or API.

---

- Publish a daily horoscope for each zodiac sign that visitors can browse.
- Show a weekly, monthly or yearly horoscope instead of (or as well as) daily.
- Place the "Astrology" block in a sidebar to list all signs with icons.
- Let visitors click a sign in the block to read its horoscope for the current period.
- Offer previous/next navigation so readers can page through days, weeks, months or years.
- Give each sign an "about" description page (element, house, key planet, strengths/weaknesses).
- Provide a "Find your star sign" form where a visitor enters their date of birth.
- Redirect a visitor from their birthday straight to their sun-sign page.
- Run a lifestyle or entertainment site's horoscope section entirely from Drupal.
- Seed a ready-made Zodiac dataset (12 signs with date ranges and icons) on install.
- Create a second, custom astrology (e.g. Chinese zodiac) alongside the default Zodiac.
- Switch which astrology is the site-wide default from the settings page.
- Choose the default display format (day/week/month/year) shown to visitors.
- Use a separate default format for administrative add/search tasks.
- Toggle a "sign information" panel that appears beside the horoscope text.
- Bulk-review, per format and date, which signs already have text via the search screen.
- Edit or update existing horoscope text for a given sign, format and date.
- Add or remove signs within a custom (non-default) astrology.
- Give each sign a custom zodiac icon shown in listings and pages.
- Localize sign display through the module's Twig templates and CSS.
- Invalidate the block cache automatically whenever astrology data changes.
- Keep horoscope content versioned in the database rather than fetched from a third party.
- Restrict all horoscope authoring to trusted administrators.
- Expose horoscope pages to anonymous visitors under standard "access content" access.
