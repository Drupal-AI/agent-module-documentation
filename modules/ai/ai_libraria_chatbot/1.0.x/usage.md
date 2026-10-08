<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Libraria Chatbot Integration embeds a third-party Libraria.ai chatbot widget on the site through a paste-in embed script rendered by a block.

---

Install the module, create an embed script at libraria.ai, and paste it at /admin/config/chatbot/settings (permission: administer site configuration). Place the 'AI Libraria Chatbot' block in a region; the block outputs the stored embed script via the embed_script theme template.

---

- Embed a Libraria.ai chatbot on the site.
- Store the vendor embed script in config.
- Render the widget through a block plugin.
- Configure the script at /admin/config/chatbot/settings.
- Gate config behind 'administer site configuration'.
- Output the embed via the embed_script template.
- Place the chatbot block per region.
- Serve as a third-party chat integration.
- Note: the embed script is admin-supplied raw markup.
- Require a Libraria.ai account/script.
- Add a single admin settings form.
- Provide one block plugin.
- Have no access-control role.
- Load an external chatbot service client-side.
- Keep the widget on public pages.
- Depend on no other contrib modules.
- Treat admin config as trusted (raw script output).
- Work across Drupal 8/9/10.
