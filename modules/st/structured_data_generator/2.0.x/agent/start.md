<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Structured Data Generator (structured_data_generator) — agent index

**Emits JSON-LD Schema.org markup into the page head via `StructuredDataGenerator` plugins; ships a breadcrumb (`BreadcrumbList`) generator.**

- **Version:** 2.0.x  •  core `^9 || ^10 || ^11`  •  PHP 8.2  •  lib `spatie/schema-org`
- **Route:** `structured_data_generator.settings` (`/admin/config/development/structured_data_generator`, perm `administer structured_data_generator`, restricted).
- **Service:** `structured_data_generator.attachments` (runs on `hook_page_attachments()`). **Plugin manager:** `plugin.manager.structured_data_generator`.
- **Plugin type:** `StructuredDataGenerator` (`Plugin/StructuredDataGenerator/`, interface `StructuredDataGeneratorInterface`, annotation `@StructuredDataGenerator`). Built-in: `breadcrumb_sdg`.
- **Routes:** single admin settings route, permission-gated; no anonymous or mutating endpoints. See [extend/plugins.md](extend/plugins.md).