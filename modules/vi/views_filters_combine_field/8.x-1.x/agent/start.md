<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Filters Combine Field (views_filters_combine_field) — agent index

Views string filter searching across multiple combined fields. Version **8.x-1.2**. Depends on `views`.

- **Plugin**: `CombineField` (`@ViewsFilter("views_filters_combine_field")`) extends core `StringFilter`.
  `query()` builds `CONCAT_WS(' ', tableAlias.realField, ...)` from admin-configured View field handlers
  and applies the selected operator.
- **Security**: search value flows through `StringFilter`/`addWhere` as bound placeholders
  (`escapeLike` for LIKE); combined expression uses Views-internal aliases, and exposed `select_field`
  is validated against existing field handlers — no user-input SQLi sink.
- **Note**: code is messy (webform/node special-casing) but sound.
