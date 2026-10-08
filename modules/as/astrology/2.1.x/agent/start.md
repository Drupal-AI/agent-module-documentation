<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Astrology (astrology) — agent index

Publishes **horoscope text for zodiac star signs**, authored on-site and shown in a block and on
public pages. On install it seeds a default **"Zodiac"** astrology with the 12 signs (Aries…Pisces).
No project dependencies (core only). Core requirement `^10 || ^11`. Package: none declared.
License GPL-2.0-or-later. Version 2.1.0.

- **Data model, tables, services, block, hooks** → [architecture](api/architecture.md)
- **Settings, routes, permissions, admin authoring workflow** → [config/settings](config/settings.md)

## What it actually is (from source)

- **Not** a field/formatter and **not** an external feed — it stores all content in three custom
  DB tables and renders admin-authored HTML text. Tables defined in `astrology.install`
  (`astrology_schema()`): `astrology`, `astrology_signs`, `astrology_text`. `astrology_install()`
  inserts the "Zodiac" row (id 1) and its 12 signs with date ranges + `img/zodiac/*.png` icons.
- **One block plugin** — `src/Plugin/Block/AstrologyBlock.php`, id **`astrology`**, admin label
  *"Astrology"*. Lists the default astrology's signs; cache tag `astrology_block`.
- **Two services** (`astrology.services.yml`):
  - `astrology.core` → `Services\AstrologyCoreService` — all DB CRUD for astrologies, signs, text
    (`@database`, `@config.factory`, `@cache_tags.invalidator`).
  - `astrology.utility` → `Services\AstrologyUtilityService` — date/format helpers
    (day=`z`, week=`W`, month=`n`, year=`o`; next/prev range math).
- **One controller** — `Controller\AstrologyController` — admin listing pages + four public pages.
- **Ten forms** under `src/Form/` — config, and CRUD for astrologies / signs / per-format text.
- **Config object** `astrology.settings` (schema in `config/schema/astrology.schema.yml`, defaults
  in `config/install/astrology.settings.yml`). Settings form is `Form\AstrologyConfig`.
- **No `*.permissions.yml`, no Drush, no custom plugin type.** Admin routes use core
  `administer site configuration`; public routes use `access content`.

## Routes at a glance (`astrology.routing.yml`)

- Admin (`administer site configuration`), under `/admin/config/astrology`: index, `list`,
  `add`, `{id}/edit`, `{id}/delete`, `list/{id}/signs` (+ add / edit / delete sign),
  `list/{id}/text` (search) and `.../text/{sign}/{text}/edit`.
- Public (`access content`): `astrology/{sign_name}/{formatter}/{next_prev}` (horoscope text),
  `astrology/{sign_name}/details`, `astrology/birth_sign` (DOB form), `astrology/{sign_name}/star-sign`.

See the two solution docs above for the full workflow, config keys and table columns.
