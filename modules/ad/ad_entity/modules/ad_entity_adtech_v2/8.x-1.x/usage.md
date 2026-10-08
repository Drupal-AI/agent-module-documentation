AdTech Factory (v2) provider for Advertising Entity — adds an `adtech_v2_factory` AdType that emits `<atf-ad-slot>` custom-element tags, with layout rules, custom slots and lazy-loading options.

---

`ad_entity_adtech_v2` is the current, supported AdTech Factory integration for the Advertising Entity framework. It registers an `adtech_v2_factory` AdType and a single `adtech_v2_default` HTML view handler that renders an `<atf-ad-slot>` custom element carrying `atf-format`, `atf-formatSize`, `atf-formatNote`, `atf-customSlot` and `atf-requestType` attributes. Global settings include the AdTech async tag (pasted from ATF personnel), weighted layout rules (default / node-type / term-type / URL-regex) that decide the `atf-contentType`, globally-defined custom slots, lazy loading, request type, and default page targeting. When the Theme Breakpoints JS module is present, ad slots can be initialized in respect of theme breakpoints. Unlike v1, personalization/consent is handled entirely by the ATF SDK's CMP, not by ad_entity. All configuration is gated by the `administer ad_entity` permission.

---

- Create AdTech Factory v2 ad units inside Advertising Entity.
- Choose each ad's format (top/vertical/content/footer/custom) and size.
- Set the `atf-formatSize`, `atf-formatNote` and `atf-customSlot` attributes per ad.
- Paste the AdTech async tag once in global settings.
- Define weighted layout rules to set the `atf-contentType` value.
- Match layout rules by node type, taxonomy vocabulary or URL regex.
- Register globally-defined custom script slots.
- Enable Google Publisher Tag lazy loading.
- Choose single-request or multi-request architecture.
- Provide default page-level targeting.
- Initialize ad slots in respect of theme breakpoints.
- Render ads as `<atf-ad-slot>` custom elements.
- Let the ATF SDK's CMP handle consent/personalization.
- Keep AdTech v2 configuration limited to `administer ad_entity`.
- Combine v2 ads with content-driven Advertising context and targeting.
