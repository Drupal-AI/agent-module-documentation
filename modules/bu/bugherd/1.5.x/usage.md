<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
BugHerd wires the hosted BugHerd feedback/bug-reporting sidebar into a Drupal site: it attaches BugHerd's loader script to pages so reviewers can click an element and file an issue against it, with a permission that controls which roles receive the widget.

---

Site review normally happens over email and screenshots, with vague descriptions a developer then has to translate into a fix. BugHerd flips that: the reviewer annotates the live page and the resulting ticket automatically carries the element, URL, browser and screen size. This module supplies the Drupal glue rather than the tracker itself. In `hook_page_attachments()` it publishes the BugHerd project key and a small widget config (`tab_position`, reporter `required`, optional label overrides, and the current user's own email when autofill is on) into `drupalSettings`, then attaches the `bugherd/bugherd` library; `js/bugherd.js` reads those settings and injects `https://www.bugherd.com/sidebarv2.js?apikey=<key>` from bugherd.com. Attachment is gated three ways: there must be a project key, the viewer must hold `access bugherd`, and if `bugherd_disable_on_admin` is set the widget is skipped on admin routes. Configuration lives at `/admin/config/development/bugherd` behind `administer bugherd`, where you set the project key, widget position (`bottom-right`/`bottom-left`), the reporter-email toggles, and 14 optional labels for BugHerd's public feedback tab. The important operational control is `access bugherd`: grant it to reviewer roles only, since the widget is client-side JavaScript delivering a publicly readable project key to every recipient of the page. Core requirement is `^10 || ^11 || ^12`, so it already covers Drupal 12.

---

- Collect visual feedback during a site build.
- Let reviewers annotate pages directly.
- Capture browser and screen details automatically.
- Show the widget only to reviewer roles via `access bugherd`.
- Hide the widget on admin pages with `bugherd_disable_on_admin`.
- Set the BugHerd project key from the settings form.
- Autofill the reporter's email from the logged-in Drupal user.
- Require an email before submitting feedback.
- Position the widget tab bottom-left or bottom-right.
- Override public-feedback widget labels (tab, placeholders, confirmations).
- Reduce ambiguity in review feedback.
- Speed up a UAT round on staging.
- Gather client feedback before launch.
- File issues against a specific page element.
- Avoid the screenshot-and-email review loop.
- Restrict the overlay by permission rather than by hiding the key.
- Support a design-review process.
- Track feedback alongside development.
- Improve QA turnaround.
- Set the key and permissions via drush/config for repeatable deploys.
- Deliver a public feedback tab to anonymous users when intended.
- Keep feedback linked to the exact URL under review.
