Integrates the Flags module with Drupal core's language system: adds flags to the language switcher and a "Language with flag" formatter/widget for core `language` fields.

---

Flags Language adds flag icons to core's language switcher block and its links via `hook_language_switch_links_alter` — each link title becomes a render array with a `flags` element (`source = language`) followed by the original title — and attaches the `flags/flags` CSS library to the language switcher block (`hook_block_view_language_block_alter`). It also provides the `language_flag` field formatter for core `language` fields (name + flag, with a `flag-before`/`flag-after`/`flag-instead` output-format setting) and a `language_select_menu` widget that is registered for the `language` field type only when the [Select Icons](https://www.drupal.org/project/select_icons) module is enabled. Flag codes are resolved through the base module's `flags.mapping.language` service, so mapping overrides configured in Flags UI apply here too. Depends on `flags` and core `language`.

---

- Add flag icons to the site's language switcher block.
- Show flags next to language switcher links in menus.
- Display a core `language` field value with its flag.
- Choose flag-before / flag-after / flag-instead output for the language formatter.
- Provide a flag-decorated language select widget (with Select Icons).
- Give multilingual visitors a visual language chooser.
- Reuse language→flag mapping overrides from Flags UI in the switcher.
- Attach the flags sprite CSS automatically wherever the switcher renders.
- Build a compact "flag only" language switcher via `flag-instead`.
- Keep switcher and field flags visually consistent via the shared sprite.
- Render language flags in a View that outputs a core `language` field.
- Correct a locale whose language code lacks a matching flag by mapping it in Flags UI.
- Add flags to the language block placed in a header or sidebar region.
- Avoid extra image requests by rendering language flags from the CSS sprite.
- Provide a flag-decorated content-language picker on entity forms (with Select Icons).
- Show the content's language with a flag on the full node display.
- Combine with flags_country for a fully flagged multilingual site.
- Let visitors recognize languages visually rather than by name alone.
