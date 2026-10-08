<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DX8 AddToAny exposes AddToAny's social share buttons as something a Site Studio component can use.

---

Site Studio builds pages from its own element vocabulary, and a share button provided by a Drupal module is not in that vocabulary unless something bridges the two. This module is the bridge: AddToAny provides the sharing, Site Studio provides the page building, and this lets a designer place the former inside the latter.

It is a small, single-purpose integration of exactly the kind a proprietary page builder generates a lot of — each capability the site already has needs re-exposing in the builder's terms.

**Social sharing widgets carry a third-party script**, and that is the thing to be deliberate about. AddToAny loads from its own domain and can set cookies for its analytics; on an EU-facing site that belongs behind consent, and the module doing the bridging does not change that. Where a site runs a consent platform, the share buttons need gating the same way any other tracker does.

The naming is historical: DX8 was Site Studio's original name, so a `dx8_` prefix indicates a module written before the rename. That is worth recognising when assessing how actively something is maintained.

---

- Add share buttons to a Site Studio page.
- Bridge AddToAny into the Site Studio palette.
- Let a designer place sharing without code.
- Re-expose an existing capability in the builder.
- Gate share buttons behind cookie consent.
- Document AddToAny cookies in a privacy notice.
- Recognise the dx8_ prefix as pre-rename.
- Assess maintenance from the naming.
- Configure which networks are offered.
- Style share buttons in Site Studio.
- Audit third-party scripts on a site.
- Plan sharing for a Site Studio build.
- Decide whether sharing needs a third party at all.
- Document this module's behaviour for the team.
- Review it during a site audit.
- Verify its assumptions after an upgrade.
