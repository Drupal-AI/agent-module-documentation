<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — services, field plugins, tokens, Views, mail

## Services
| Service | Class | Role |
|---|---|---|
| `forward.form_builder` | `Services\ForwardFormBuilder` | Builds/renders the Forward form (used by the form formatter and route). |
| `forward.link_generator` | `Services\ForwardLinkGenerator` | Builds the Forward link markup (icon/text styles). |

## Field plugins (Manage display / Manage fields)
- Formatter `forward_link` (`Plugin/Field/FieldFormatter/ForwardLinkFormatter`) — renders a "Forward"
  link. Settings (`field.formatter.settings.forward_link`): `title`, `style` (link style), `icon`
  (custom icon path), `nofollow`.
- Formatter `forward_form` (`Plugin/Field/FieldFormatter/ForwardFormFormatter`) — renders the Forward
  form inline on the entity.
- Field type `forward` (`Plugin/Field/FieldType/ForwardItem`) + widget `Plugin/Field/FieldWidget/ForwardWidget`
  — an extra field you add to a bundle to place the link/form. (The link/form can also be shown as an
  extra field on the display.)

## Tokens (`forward.tokens.inc`)
Token group `forward` with e.g. `[forward:sender-name]`, `[forward:sender-email]`,
`[forward:entity-title]`, `[forward:entity-type]`, recipients, plus standard `[site:*]`. The sender name
is URL-stripped (`cleanString`) before use to harden against abuse.

## Views (`config/optional`)
- `views.view.forward_logs` — the `forward_log` table (per-send log: type, id, path, action, timestamp,
  uid, hostname/IP).
- `views.view.forward_statistics` — the `forward_statistics` table (per-entity `forward_count`,
  `last_forward_timestamp`). Views integration data in `forward.views.inc`.

## Mail
- `Plugin/Mail/ForwardMail` — mail plugin used with keys `send_entity` (when core `php_mail` is the
  default) / `mail_entity` (when another transport like SMTP is active), so SMTP/Symfony Mailer modules
  are honoured automatically.

## Migrate
- Source plugins `Plugin/migrate/source/ForwardLog` & `ForwardStatistics`; destination plugins under
  `Plugin/migrate/destination/` (+ `migration_templates/`) to bring D7-era forward data forward.

## Programmatic
There is no dedicated "send forward" service call — reach the feature via the form/route
(`/forward/{entity_type}/{entity}`) or the formatters; extend behaviour with the hooks/events in
[../hooks/hooks.md](../hooks/hooks.md).
