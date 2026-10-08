# IEF Complex Widget Dialog — enabling & how it works

No settings page. The only configuration is a per-widget checkbox; the rest is automatic markup.

## Enable the popup on a field
1. Field must use the **Inline entity form - Complex** widget (`inline_entity_form` complex widget)
   on an entity's *Manage form display*.
2. In that widget's settings gear, check **"Enable Popup for IEF"**.
3. Saved as the widget third-party setting
   `content.<field>.settings` → `third_party_settings.ief_popup.ief_popup_enabled: true`
   in the relevant `core.entity_form_display.*` config. Uncheck to revert to stock inline IEF.

The settings summary shows "Display the form in a popup." when enabled
(`hook_field_widget_settings_summary_alter`).

## Form-alter flow (all in `ief_popup.module`)
- `hook_field_widget_third_party_settings_form()` — adds the checkbox for `InlineEntityFormComplex` widgets.
- `hook_field_widget_single_element_inline_entity_form_complex_form_alter()` — on the host form; when
  the widget has `ief_popup_enabled`, handles the "remove" confirmation row and the "add existing"
  form, computing parent-entity title/bundle for `node`/`block_content`/`taxonomy_term`/`user`
  (and a Layout Builder `ConfigureBlockFormBase` special case) and calling `ief_popup__process_ief_form()`.
- `hook_inline_entity_form_entity_form_alter()` — for the add/edit/duplicate sub-forms; finds the
  owning field name from `#parents`, reads the form-display component's third-party setting, and if
  enabled calls `ief_popup__process_ief_form($ief_form, $ief_form['#op'])`.

## `ief_popup__process_ief_form(&$ief_form, $action, $parameters = [])`
Purely presentational. It:
- sets `#prefix`/`#suffix` wrapping the sub-form in overlay + dialog markup
  (classes `ief-popup-overlay ui-widget-overlay`, `ief-popup-wrapper ief-popup-wrapper-<action>`,
  `ui-dialog ui-corner-all ui-widget ui-widget-content ui-front ui-dialog-buttons`);
- picks a contextual `$popup_title` per `$action` (`add`/`edit`/`duplicate`/`view`/`remove`/`existing`),
  using the entity title for edit/duplicate and a "Are you sure you want to remove …" message for remove;
- injects a title bar (`ui-dialog-titlebar`) with a close control (`.ief-popup-close`) into
  `$ief_form['first']` (weight -1000);
- registers `#after_build` = `ief_popup__ief_form_after_build`, which adds `button--primary` to the
  IEF save/confirm buttons and `.ief-popup-cancel` to the cancel buttons, and closes the content wrapper.

## Frontend assets
`ief_popup.libraries.yml` → library `ief_popup`: `css/ief_popup.css` (theme), `js/ief_popup.js`,
deps `core/jquery`, `core/drupal`, `core/drupal.dialog`. Attached on **every** page via
`hook_preprocess_page()` (`$variables['#attached']['library'][] = 'ief_popup/ief_popup'`); the JS wires
the close/overlay behaviour and `.ief-popup-cancel` handling.
