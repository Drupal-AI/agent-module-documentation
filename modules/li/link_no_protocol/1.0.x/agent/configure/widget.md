# The `link_no_protocol` widget

Class: `Drupal\link_no_protocol\Plugin\Field\FieldWidget\NoProtocolLinkWidget` extends core
`Drupal\link\Plugin\Field\FieldWidget\LinkWidget`.

## Enable it

*Manage form display* for the bundle → set the Link field's Widget to **Link No Protocol**. There is no global
config; the choice and its settings are stored in the `core.entity_form_display.*` config for that bundle.

## Setting

| Setting | Default | Effect |
|---|---|---|
| `remove_protocol_default_value` | `TRUE` | On `formElement()`, strips `http://`/`https://` from the field's `#default_value` URI so the editor sees a protocol-less default. |

`settingsForm()` adds the checkbox; `settingsSummary()` appends "Users are allowed to not use protocol in URLs."
and, when the setting is on, "The protocol is removed from the default value".

## Behavior

- `formElement()` sets `$element['uri']['#type'] = 'textfield'` (core uses `url`, which blocks protocol-less input).
- `getUserEnteredStringAsUri($string)` (static, protected):
  1. If `$string` does not match `/^(http|https)/`, build `https://www.<trimmed>` and `parse_url()` it.
  2. If `validateDomain($host)` is TRUE, use that as the URI; otherwise leave the string unchanged.
  3. Always calls `parent::getUserEnteredStringAsUri()` afterward for core's normal URI handling.
- `validateDomain($domain)` returns TRUE when `filter_var(gethostbyname($domain), FILTER_VALIDATE_IP)` succeeds
  (i.e. the host resolves in DNS). Note this performs a DNS lookup on the editor-entered host at form-submit time.

Storage is unchanged from core Link — a fully-qualified URI is still saved. This widget only affects data entry,
not the stored value's format.
