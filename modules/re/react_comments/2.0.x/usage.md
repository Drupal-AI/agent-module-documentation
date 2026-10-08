<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
React Comments provides a commenting system built with React, rendering and posting Drupal comments via REST.

---

React Comments provides a commenting UI built with React — replacing the default comment display/form
with a React front-end that reads and posts Drupal comments via REST, giving a more dynamic (SPA-style)
commenting experience. It depends on core Comment and REST and is configured at `react_comments.settings`.

Use it for a modern, dynamic comment experience. The security-relevant points are the standard ones for
comments over REST: the REST resources for reading/posting comments must be properly access-controlled
(comment permissions still apply — who can view/post/edit comments), spam/flood protection should be in
place (a JS comment form is still a public POST endpoint), and comment content is user input that must be
sanitized (Drupal's comment system handles this, but confirm the React rendering escapes it). It has no
access-control role of its own beyond relying on comment/REST permissions. Configure the comment display.

---

- Provide a React commenting UI.
- Read/post comments via REST.
- Give a dynamic comment experience.
- Depend on core Comment and REST.
- Configure at react_comments.settings.
- Access-control the comment REST resources.
- Rely on comment permissions.
- Add spam/flood protection.
- Sanitize comment content.
- Confirm React rendering escapes input.
- Replace default comment display.
- Post comments dynamically.
- Render comments with React.
- Handle comment permissions.
- Protect the comment POST endpoint.
- Treat comments as user input.
- Provide SPA-style comments.
- Configure the comment UI.
- Support dynamic commenting.
- Use comments over REST.
