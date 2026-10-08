# Widget settings

Widget id: `tagify_user_list_entity_reference_autocomplete_widget` (set on a user
entity-reference field under *Manage form display*). Config schema
`field.widget.settings.tagify_user_list_entity_reference_autocomplete_widget`.

Defaults (from `defaultSettings()`):

| Key | Default | Meaning |
|---|---|---|
| `match_operator` | `STARTS_WITH` | Matching mode; *Contains* can be slow on large user tables. |
| `match_limit` | 10 | Max suggestions (0 = unlimited). |
| `suggestions_dropdown` | on first character | When the dropdown opens. |
| `placeholder` | '' | Empty-field placeholder. |
| `image` | `user_picture` | User image field used for the avatar. |
| `image_style` | `thumbnail` | Image style applied to the avatar. |
| `show_info_label` | 1 | Show an info label beside each user. |
| `info_label` | `[user:mail]` | Token string for the info label. |
| `show_entity_id` | 0 | Include the user ID within the tag. |

Users lacking a picture fall back to the bundled `images/no-user.svg`.
