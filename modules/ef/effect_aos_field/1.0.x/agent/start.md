<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Effect AOS Field (effect_aos_field) — agent index

**Field type that applies AOS (Animate On Scroll) effects to sibling fields per entity instance, set from the edit form.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Package:** Field types
- **Dependencies:** none declared (AOS library from CDN)
- **No routes / permissions.**
- **Service:** `effect_aos_field.attributes_manager` (AttributesManager — YAML plugin manager over `*.options.yml`)
- **Plugins:** FieldType `effect_aos` (EffectAosItem, JSON in one column), FieldWidget `effect_aos_widget`, FieldFormatter `effect_aos_formatter` (renders nothing). Field-type category `aos_effects`.
- **Render:** `hook_entity_view` stashes effects onto target fields; `hook_preprocess_field` writes `data-aos-*` attributes.
- **Libraries:** `aos_field_widget` (local), `animate_aos_library` (AOS 3.0.0-beta.6 from cdnjs).
- **Security:** No routes/SQL/unserialize/secrets. Widget JSON sanitized to a whitelist in `massageFormValues`; `data-aos-*` rendered via Drupal's auto-escaped attribute system → no stored XSS. Observation: `effect_aos_field.libraries.yml:159-161` loads AOS CSS/JS from an external CDN with **no SRI hash** (supply-chain/tamper/availability risk, not an exploitable bug).

See [plugins/field.md](plugins/field.md).
