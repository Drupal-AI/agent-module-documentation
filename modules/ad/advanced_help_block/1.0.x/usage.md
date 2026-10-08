<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Help Block lets editors author help notices as fielded content entities (title, filtered rich-text body, optional YouTube video, path-visibility rules) that render through Drupal core's Help block on the pages you scope them to.

---

The guidance an editorial team needs is site-specific and lives in the wrong place. "Use the summary field for the homepage card, not the teaser." "Images on this content type must be 16:9." "Ask the legal team before publishing anything in this section." That knowledge exists in a wiki nobody opens, an email from two years ago, or the head of one person — and the moment it is needed is while someone is looking at the form it applies to. Putting it on that page, maintained by the team rather than by a developer, is the intervention that actually works, and it is why core ships a `help` module that most sites never populate. This module does exactly that: each notice is a content entity with a title, a rich-text description filtered through a text format, an optional YouTube link that opens in a modal, and comma-separated path patterns (with `*` wildcards and `<front>`) plus an include/exclude rule that decide where it shows. There is no custom block plugin — the module implements `hook_help()`, so the notices surface through **core's own Help block**, which you must place in a region (or switch the setting to render them as status messages instead); each notice is collapsible and dismissible, remembered per visitor in a cookie. Version **1.0.8** on `^9 || ^10 || ^11`, from the **YMCA Website Services / Open Y** distribution — which explains the dependency list, notably **`datalayer`**, a tracking-adjacent module, and the external **grt-youtube-popup** asset expected in `/libraries`, both worth noticing before installing this outside that distribution. Permissions cover view, add and edit of the help block entities separately, which is the right split: writing guidance is an editorial act and should not require the permission to configure blocks. Two practical notes. **Help that is wrong is worse than no help**, because it is trusted — so guidance needs an owner and a review point, the same as any other content. And **the audience is authenticated editors on administrative pages**, so the blocks should be scoped to those routes rather than placed site-wide, both to avoid leaking internal instructions onto public pages and because guidance shown where it does not apply trains people to ignore it.

---

- Show editorial guidance on a node form.
- Explain a field's expected content.
- Add onboarding help for new editors.
- Document a content type's rules.
- Show image dimension requirements.
- Remind editors of a review step.
- Add site-specific help to an admin page.
- Reduce repeated editorial questions.
- Document a publishing workflow.
- Explain a section's approval process.
- Show guidance where it is needed.
- Maintain help without a developer.
- Add contextual help to a view.
- Document a taxonomy's intended use.
- Support an editorial handover.
- Explain a form's less obvious fields.
- Reduce training burden for editors.
- Show policy reminders in context.
