<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Riddle Marketplace imports and displays riddles in Drupal.

---

Riddle Marketplace **imports and displays Riddle content** — quizzes, polls and interactive content from
the Riddle platform — as Drupal media (with a `media_riddle_marketplace` submodule), so Riddle interactives can
be embedded in content. It provides its own permissions, in the Riddle package.

Use it to embed Riddle quizzes/polls. It is a media/integration feature. Security/data handling: it
authenticates to the **Riddle API with credentials/tokens** — store as **secrets** (env/Key), HTTPS — and the
interactive content is hosted/served by **Riddle** (third-party embed; participant data is handled by Riddle —
a privacy consideration). Its permission gates configuration. Configure the Riddle credentials.

---

- Import Riddle quizzes/polls.
- Display Riddle as media.
- Embed interactive content.
- Provide a media submodule.
- Authenticate with Riddle API tokens.
- Serve interactive embeds.
- Store credentials as secrets.
- Use HTTPS.
- Note participant data is handled by Riddle (privacy).
- Provide its own permissions.
- Have no access-control role beyond permission.
- Configure the Riddle credentials.
- Handle Riddle.
- Embed quizzes.
- Configure the integration.
- Import riddles.
- Handle the media.
- Embed polls.
- Secure the credentials.
- Provide Riddle embedding.
