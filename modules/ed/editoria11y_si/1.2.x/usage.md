<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Editoria11y SI (Siteimprove) pulls QA/accessibility data from Siteimprove and shows it via the Editoria11y interface.

---

Editoria11y SI (Siteimprove) **pulls quality-assurance data from Siteimprove** and surfaces it through the
Editoria11y accessibility checker's interface — so Siteimprove-detected issues appear alongside Editoria11y's
in-page checks. It depends on the Editoria11y module and the **Key** module, provides its own permissions.

Use it to see Siteimprove QA issues in Editoria11y. It is an accessibility/integration tool. Security/data
handling: it **calls the Siteimprove API** (egress) and authenticates with **credentials stored via the Key
module** (secret handling, a positive). The QA data is editor-facing. It has no access-control role beyond its
permission. Configure the Siteimprove credentials (via Key).

---

- Pull Siteimprove QA data.
- Show issues in Editoria11y.
- Combine QA with in-page checks.
- Depend on Editoria11y + the Key module.
- Provide its own permissions.
- Serve accessibility.
- Call the Siteimprove API (egress).
- Store credentials via the Key module (positive).
- Show editor-facing QA data.
- Have no access-control role beyond permission.
- Configure the Siteimprove credentials via Key.
- Handle Siteimprove QA.
- Fetch QA data.
- Configure the client.
- Show issues.
- Handle the integration.
- Surface QA.
- Display accessibility issues.
- Secure the credentials via Key.
- Provide Siteimprove QA display.
