# Field formatter, widget & text filter

All three surface a "Send to phone" link that opens the send form
([configure/settings.md](../configure/settings.md)) pre-filled with the content to text.

## Formatter — `sms_link`

`Drupal\sms_sendtophone\Plugin\Field\FieldFormatter\SmsLinkFormatter` (label "SMS Link",
`field_types = {"text"}`). Renders the field value plus a `(Send to phone)` link to
`sms_sendtophone.page` with `type=field` and the stripped text passed as the `text` query parameter.
Enable it on a text field's display like any formatter.

## Widget — `sms_sendtophone`

`Drupal\sms_sendtophone\Plugin\Field\FieldWidget\SmsSendWidget` (label "Text Field and SMS send to
phone", `field_types = {"text"}`). A text input/area widget (`rows` setting: 1 → textfield, else
textarea) intended to pair with the SMS-send flow. Select it as the field's form widget.

## Text filter — `filter_inline_sms`

`Drupal\sms_sendtophone\Plugin\Filter\FilterInlineSms` (title "Inline SMS"). In any text format,
text wrapped in `[sms]…[/sms]` is highlighted and gets an appended "send to phone" link/icon to
`sms_sendtophone.page` with `type=inline` and the wrapped text as the `text` query parameter.
Settings: `display` (`icon`|`text`), `display_text`, `default_icon`, `custom_icon_path`.

## Node link

Independently of fields, `sms_sendtophone_node_links_alter()` adds a "Send to phone" link
(`type=node`, `extra`=node id) to nodes whose bundle is enabled in
[`sms_sendtophone.settings:content_types`](../configure/settings.md).
