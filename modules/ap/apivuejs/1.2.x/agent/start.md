<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# apivuejs

JSON backend for a Vue.js client: generates entity forms and does entity CRUD.

- Controller `src/Controller/ApivuejsController.php`. Data routes gated by permission `edit-create apivuejs entities` (restrict access) + `_auth: basic_auth,cookie`.
- Save/update calls `$entity->access('update')`; queries use `->accessCheck()`.
- CAUTION: `edit-create apivuejs entities` is one coarse permission spanning create/update/delete of ALL entity types — trusted roles only.
- Settings at `/admin/config/system/apivuejs`. Perms also include `canonical apivuejs entities`, `administer apivuejs configuration`.

See [../usage.md](../usage.md).
