# Theming the banner

`eu_cookie_compliance_theme()` registers four theme hooks, each backed by a Twig template in
`templates/`. Override by copying the template into your theme (or implement
`hook_theme_suggestions`/preprocess).

| Theme hook / template | Purpose | Notable variables |
|---|---|---|
| `eu_cookie_compliance_popup_info` | Main "info" banner | `message`, `agree_button`, `disagree_button`, `more_info_button`, `cookie_categories`, `withdraw_button_on_info_popup`, `method` |
| `eu_cookie_compliance_popup_info_consent_default` | Category/consent‑default banner | `message`, `agree_button`, `disagree_button`, `secondary_button_label` |
| `eu_cookie_compliance_popup_agreed` | Post‑consent "thank you" state | `message`, `hide_button`, `find_more_button` |
| `eu_cookie_compliance_withdraw` | Withdraw‑consent tab | `withdraw_tab_button_label`, `message`, `withdraw_action_button_label` |

## CSS libraries (`eu_cookie_compliance.libraries.yml`)
- `eu_cookie_compliance` — core JS (jQuery/drupal/once), always loaded.
- `eu_cookie_compliance_default` / `_bare` / `_olivero` — pick a base stylesheet; `_olivero`
  targets the Olivero theme. Templates also emit `olivero_primary_button_classes` /
  `olivero_secondary_button_classes` for theme‑matched buttons.

Attach your own styling by depending on `eu_cookie_compliance/eu_cookie_compliance` and adding
a CSS library in your theme, or by choosing "Bare" in the settings form and styling from scratch.
