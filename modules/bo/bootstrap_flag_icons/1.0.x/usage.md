Adds a Bootstrap 5 flag-icon language-switcher block and a CKEditor 5 button for inserting country/flag icons into rich-text content.

---

Bootstrap flag icons is a small presentational multilingual helper. It ships a custom block plugin ("Bootstrap Language switcher") that extends core's language switcher and re-themes it as a Bootstrap 5 dropdown, showing a flag icon for the current language and for each available language. Flag styling comes from the `lipis/flag-icons` CSS library, pulled from a jsDelivr CDN. Separately it registers a CKEditor 5 plugin ("Flag Icon") that lets editors search a bundled icon list by ISO code, English/French name, or country code and insert an `<i class="fi …">` flag element into the body. There are no routes, permissions, services, or admin settings pages: the block is configured per-placement, and the CKEditor plugin is configured per text format. Best paired with a Bootstrap 5 admin theme.

---

- Place the "Bootstrap Language switcher" block in a region to give visitors a flag-based language dropdown.
- Offer language selection using recognizable country flags instead of plain text links.
- Choose between "Icons and text" or "Only icons" display per block placement.
- Provide a compact, icon-only switcher for a header or top bar where space is tight.
- Match a Bootstrap 5 theme's dropdown styling for the language switcher without custom CSS.
- Show the current interface language as a flag in the collapsed dropdown button.
- Fall back to a globe icon when the current language has no matching flag.
- Add a "Flag Icon" toolbar button to a CKEditor 5 text format for editors.
- Let content editors insert a national/regional flag inline in body text.
- Search flags by ISO 3166 country code (e.g. `fr`, `de`, `jp`) when inserting.
- Search flags by English or French country name in the CKEditor picker.
- Insert flags as CSS `<i class="fi">` elements, or as `<img>` when the plugin's image option is enabled.
- Pick a 1:1 or 4:3 flag ratio for inserted CKEditor icons.
- Load flag CSS from the module's local assets, or force the CDN when the admin theme lacks flag styles.
- Decorate multilingual navigation with flags to signal available translations.
- Build a country/region selector visual style reusing the bundled SVG flag set.
- Illustrate language-specific promotions or notices with the matching flag icon.
- Support switcher blocks for each configurable language type (interface, content, URL).
- Provide an accessible dropdown with `lang` attributes on each language option.
- Keep the switcher consistent with Bootstrap components already used elsewhere on the site.
- Give editors a quick way to add flags to tables, lists, or callouts in rich text.
- Standardize flag rendering across a multi-site or multi-brand Bootstrap build.
