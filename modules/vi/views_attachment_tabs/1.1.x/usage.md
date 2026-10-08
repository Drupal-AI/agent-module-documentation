<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Attachments as Tabs renders a view's main display and its attachment displays as a tabbed interface instead of a stacked main-view-plus-attachments layout, without any custom templates.

---

Views attachments already let one display hang off another — a "related content" list beneath a main listing, a summary above a table — but they stack; they give you no way to present several of them as switchable alternatives, which is what a tabbed panel is. This module adds a Views **display extender** that puts an *Enable / Tab title / Tab weight* option group on any display that uses attachments and on each attachment, then supplies a dedicated theme hook and preprocess that gather the main view plus every enabled attachment into ordered tab buttons (`role="tab"`) and panels (`role="tabpanel"`), sorted by weight. Install it, then enable the **"Views attachment tabs"** display extender under **Structure → Views → Settings → Advanced** (this is a manual step — the module does not tick it for you), open a view's **Attachment tabs** group to enable and title the main tab, and click **Attach as tab** on each attachment to add it. The module ships **no CSS or JS itself**, so pick a theme layer: enable `views_attachment_tabs_bootstrap` for Bootstrap 4/5 themes, enable `views_attachment_tabs_olivero` for core's **Olivero** (adds the interactive JS and a mobile trigger), or implement `hook_preprocess_views_view_attachment_tabs()` to add your theme's own tab classes and behavior. An optional **tokenize** setting lets a tab title use Views field/argument tokens from the first row. Accessibility is the thing to verify with any tab UI — a correct set needs `aria-selected`, arrow-key navigation between tabs, and only the active panel exposed — and note that every panel is rendered into the DOM up front, so inactive-tab content still costs query time and is findable by in-page search. Requires Drupal `^9 || ^10 || ^11` and core Views only.

---

- Present a view and its attachments as switchable tabs.
- Show related views as tabs on one page.
- Turn a summary display and a detail display into two tabs.
- Group several attached listings into a tabbed panel.
- Reduce vertical page length on a listing page.
- Show taxonomy categories as separate tabs.
- Build a tabbed report or dashboard from one view.
- Present filtered variants of a list side by side.
- Show archive years or months as tabs.
- Keep related content together without extra pages.
- Match a Bootstrap theme's native tab component.
- Match Olivero's primary-tabs styling and mobile behavior.
- Avoid writing a custom tab template and JavaScript per site.
- Order tabs deterministically with a per-tab weight.
- Use a token-driven tab title from the first result row.
- Add accessible `role="tablist"`/`tab`/`tabpanel` markup to a view.
- Provide theme-specific tab markup via a preprocess hook.
- Reduce navigation between separate listing pages.
- Organize a long page into compact tabbed sections.
- Show a block view's attachments as tabs inside a region.
