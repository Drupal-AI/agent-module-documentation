<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Astrology — settings, routes, permissions, authoring workflow

## Install / enable

`drush en astrology` (or `ddev drush en astrology`). No project dependencies (core only), core
`^10 || ^11`. On enable, `astrology_install()` creates the three tables and seeds the "Zodiac"
astrology (id 1) + its 12 signs. `configure` route is `astrology.admin_index`
(**Configuration → Astrology**, `/admin/config/astrology`).

## Config object `astrology.settings`

Schema: `config/schema/astrology.schema.yml` (`type: config_object`). Install defaults:
`config/install/astrology.settings.yml`. Keys:

| key | type | meaning | default |
|-----|------|---------|---------|
| `astrology` | integer | id of the site-wide **default** astrology | `1` |
| `sign_info` | boolean | show the "sign information" panel beside horoscope text | `true` |
| `format_character` | string | site-wide default period: `day`/`week`/`month`/`year` | `day` |
| `admin_format_character` | string | period used by the admin add/search screens | `day` |
| `sign_id` | integer | sign preselected in the admin text search (`0` = ALL) | `0` |
| `cdate` | string | cached site-wide date value for the current format | (set on save) |
| `admin_cdate` | string | cached admin date value for the current format | (set on save) |

Written by `Form\AstrologyConfig` (a `ConfigFormBase`, form id `astrology_config`, editable name
`astrology.settings`). Its `submitForm()` disables all astrologies, enables the chosen one via
`astrology.core`, and saves the format/astrology/sign_info plus recomputed `cdate`/`admin_cdate`
(from `AstrologyUtilityService::getCdate()`). This form is embedded on the admin list page by
`AstrologyController::astrologyConfig()`.

## Routes & access (`astrology.routing.yml`)

**Admin — all require `_permission: administer site configuration`** (numeric params constrained by
regex like `astrology_id: ^[0-9]+`):

- `astrology.admin_index` `/admin/config/astrology` — system menu block.
- `astrology.list_astrology` `/admin/config/astrology/list` — astrology table + settings form.
- `astrology.add_astrology` / `astrology.edit_astrology` `{id}/edit` / `astrology.delete_astrology`
  `{id}/delete` — CRUD an astrology (`Form\AstrologyAddForm` / `AstrologyEditForm` /
  `AstrologyDeleteForm`).
- `astrology.list_astrology_sign` `list/{id}/signs`, `astrology.add_astrology_sign`,
  `astrology.edit_astrology_sign`, `astrology.delete_astrology_sign` — CRUD signs
  (delete link hidden for the default Zodiac, id 1).
- `astrology.astrology_sign_list_text` `list/{id}/text` — per-format text search
  (`Form\AstrologySignTextSearch` + a results table).
- `astrology.add_text_astrology_sign` `list/{id}/signs/{sign_id}/text` and
  `astrology.astrology_sign_text_edit` `.../text/{sign_id}/{text_id}/edit` — add / edit horoscope
  text (`Form\AstrologySignAddTextForm` / `AstrologySignEditTextForm`).

**Public — require `_permission: access content`:**

- `astrology.list_text_sign_format` `astrology/{sign_name}/{formatter}/{next_prev}` — horoscope text
  for a sign in the given period; controller rejects unknown formatters / out-of-range `next_prev`
  with 404.
- `astrology.sign_details` `astrology/{sign_name}/details` — the sign's "about" page.
- `astrology.astrology_birth_form` `astrology/birth_sign` — DOB form (`Form\AstrologyBirthSign`).
- `astrology.astrology_birth_sign` `astrology/{sign_name}/star-sign` — sun-sign result page.

**Permissions:** the module ships **no** `astrology.permissions.yml`. Authoring is gated on core
`administer site configuration` (a highly privileged permission — grant only to trusted admins);
front-end viewing on `access content`.

## Authoring workflow (typical)

1. **Configuration → Astrology → Astrology settings** (`/admin/config/astrology/list`): pick the
   default astrology, the site-wide format, and the admin format; toggle *Display sign information*.
2. From the astrology table, open **Signs** to review the 12 Zodiac signs (or **Add astrology** to
   create a new one, then add its signs).
3. For a sign, choose **Add text**. The add form (`AstrologySignAddTextForm`) shows a date/period
   widget matching `admin_format_character` (day/week → date picker; month/year → select) and a
   `text_format` field (default `full_html`). On submit it computes the period `value`
   (`z`/`W`/`n`/`o`) + `post_date` and inserts into `astrology_text`, or updates the existing row if
   one already exists for that sign/format/date.
4. Use **Text** (search screen) to see, per format and date, which signs already have text and edit
   them.
5. Place the **Astrology** block (Block layout) and/or link visitors to
   `astrology/{sign}/{format}/0` or the **Find your star sign** form at `astrology/birth_sign`.

## Notes

- Exactly one astrology is `enabled` at a time; saving settings or deleting the default reassigns it
  (see `AstrologyCoreService::updateDefaultAstrology`).
- Changing signs/text or settings invalidates cache tag `astrology_block`, refreshing the block.
- `date_range_from` / `date_range_to` use `"M/D"`; the DOB form matches a birthday to a sign by
  comparing month/day against these ranges, then redirects to the sun-sign page.
