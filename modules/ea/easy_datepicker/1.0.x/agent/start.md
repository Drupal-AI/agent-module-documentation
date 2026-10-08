<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy Datepicker (easy_datepicker) — agent index

**Lightweight, dependency-free datepicker Form API element + Webform textfield add-on with fast year/month paging.**

- **Version:** 1.0.x
- **Core:** ^10.2 || ^11
- **Package:** Custom
- **Dependencies:** none (Webform integration is soft — hook only fires if Webform is installed)
- **Routes:** `/easy-datepicker/demo` (`access content`, read-only demo form); `/admin/config/content/easy-datepicker` (`administer easy_datepicker settings`, restricted, real config)
- **Element:** `EasyDatepicker` (`#type => easy_datepicker`, extends Textfield). Library `easy_datepicker/datepicker`.
- **API/hooks:** `easy_datepicker_attach()`, `hook_easy_datepicker_options_alter()`, `easy_datepicker_webform_element_alter()`, `easy_datepicker_normalize_date_value()` validate callback.
- **Security:** The `access content`-gated `/easy-datepicker/demo` is a read-only demo form (no mutation; the actual settings mutation lives behind the restricted admin permission). Value normalization uses strict `DateTime::createFromFormat` + `getLastErrors()` rejection; no SQL, external I/O or unsafe sinks. No security findings.

See [extend/element.md](extend/element.md).
