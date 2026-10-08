Dropdown Language Switcher provides a language switcher **block** that renders the available site languages as a single core Dropbutton (dropdown) instead of the plain unordered list of links produced by core's own language switcher block.

---

The module ships one block plugin (`dropdown_language`) that is derived per configurable language type (Interface, Content, URL, etc.), so you can place a separate dropdown for each language negotiation type. The block is only visible when the site is multilingual (two or more languages), and by default renders nothing when the current page has fewer than two available links; the active language is floated to the top of the list, marked with an `active-language` class, and rendered as a `<nolink>` (self-reference removed). A single global settings form at Admin → Configuration → Regional and language → Dropdown Language Switcher controls how every dropdown labels its languages — by Language Name, Language ID (uppercased code), Native Name, or Custom Labels — plus an optional "Switch Language" fieldset wrapper, an SEO option to remove links to untranslated entity translations the user cannot view, and an option to keep the block visible even with a single language. When Custom Labels is chosen, each placed block instance exposes per-language textfields (stored in the block's own `labels` config) so labels can be set per instance. The block declares `getCacheMaxAge() = 0` (uncacheable) and adds the `config:configurable_language_list` cache tag. It requires only core `language` and `block`; no external libraries, permissions, or Drush commands.

---

- Replace core's list-style language switcher with a compact dropdown/dropbutton in a header, sidebar, or footer.
- Give a multilingual site a single-click language menu that puts the current language on top.
- Place a dropdown bound specifically to the Interface language negotiation type.
- Place a separate dropdown for the Content language type on entity pages.
- Place a dropdown for the URL language type to switch the path prefix / domain.
- Show language codes (EN, FR, DE) instead of full names to save horizontal space.
- Display each language in its own native name (e.g. "Deutsch", "Français") via the Native Name option.
- Set fully custom per-language labels (e.g. flags-as-text or brand wording) per block instance.
- Wrap the switcher in a labelled "Switch Language" fieldset for visual grouping.
- Improve SEO by hiding switcher links to entity translations that do not exist.
- Hide switcher links to translations the current user's role cannot view.
- Keep the block rendered even when only one language currently applies (via "always show block").
- Automatically hide the switcher on 403/404 pages to avoid broken switch links.
- Automatically hide the block on monolingual sites without extra visibility rules.
- Configure all dropdowns' labelling style from one central settings form.
- Add a language switcher whose markup uses core's themable Dropbutton element for consistent styling.
- Style the active language with the `active-language` CSS class.
- Build a right-to-left friendly switcher that reuses core language switch links.
- Offer distinct language menus per region by placing multiple block instances with per-language visibility.
- Provide a translator-friendly workflow where "Switch Language" and labels are translatable interface strings.
- Deploy switcher label behaviour as exported config (`dropdown_language.setting`) across environments.
- Swap in a dropdown switcher without writing a custom Twig template or theme preprocess.
- Restrict a Custom-Labels dropdown to one language per block instance using core block Language visibility.
- Ensure switcher visibility invalidates correctly when languages are added/removed (via the config cache tag).
- Present a themeable language selector in a decoupled-friendly, JS-free (server-rendered) manner.
