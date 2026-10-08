<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Comment Moderation sends each new comment to OpenAI's Moderation API and unpublishes any comment the API flags as inappropriate.

---

AI Comment Moderation is a small module that wires Drupal's core comment save cycle to OpenAI's Moderation endpoint. On comment presave it passes the comment body to a service that POSTs the text to `https://api.openai.com/v1/moderations`; if OpenAI returns `flagged: true` (hate, violence, sexual, or harassment categories) the module calls `setUnpublished()` on the comment and shows the author a warning that it was held. Configuration is a single admin form (`/admin/config/content/ai-comment-moderation`, gated by `administer site configuration`) where you store the OpenAI API key. The only dependency is the core comment module plus a valid OpenAI API key. Comment text is sent to OpenAI for classification, which has cost and data-egress implications you should confirm are acceptable for your content.

---

- Auto-classify new comments with OpenAI's Moderation API.
- Unpublish comments the API flags as inappropriate.
- Warn the author when their comment is held.
- Screen hate, violence, sexual, and harassment content.
- Keep public comment sections cleaner on blogs and forums.
- Reduce manual moderation on community and news sites.
- Store the OpenAI API key on a dedicated settings form.
- Integrate with the core Comment module without extra fields.
- Run moderation in real time at comment save.
- Apply moderation to any bundle that uses core comments.
- Operate on Drupal 10 and 11.
- Use OpenAI's classification-only Moderation endpoint (not a chat model).
- Configure with a single API key and no other options.
- Add a lightweight moderation gate to educational or forum sites.
- Complement human review rather than replace it.
- Provide a minimal starting point for OpenAI comment moderation.
