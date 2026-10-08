<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lupus Decoupled Responsive Preview makes the Responsive Preview module show the decoupled front end rather than Drupal's own rendering.

---

Responsive Preview lets an editor check how content looks at different device widths without leaving Drupal. On a decoupled site its default behaviour is misleading: it previews Drupal's rendering, which is not what visitors see.

This submodule points it at the front end instead, so the preview frame shows the actual decoupled output at the selected width. That restores a check editors rely on and removes a class of "it looked fine in preview" surprises.

What to verify is that the preview URL reaches a front end that can render unsaved or unpublished content — which is a separate concern, usually handled by a preview mode in the front end and an authenticated request. A responsive preview that shows the published version of a draft is worse than none, because it looks authoritative.

---

- Preview decoupled output at device widths.
- Check a mobile layout from inside Drupal.
- Stop previewing Drupal's own rendering.
- Give editors an accurate responsive check.
- Preview unpublished content in the front end.
- Authenticate the preview request.
- Avoid previewing the published version of a draft.
- Verify preview mode in the front end.
- Reduce late surprises from inaccurate previews.
- Check a layout at tablet width.
- Support editorial review on a headless site.
- Combine with a decoupled preview flow.
- Debug a preview showing stale content.
- Configure preview URLs per environment.
- Document the preview flow for editors.
