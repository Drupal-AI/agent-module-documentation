# Nice Login — agent index

Restyles the three core user auth pages (`user.login`, `user.pass`, `user.register`): removes
their local-task tabs and injects cross-links between the forms. Markup/CSS only — no config UI
(`configure` null), no permissions, no schema, no change to authentication logic. Depends on core `user`.

- **Theme hooks, the form alters, injected links, the removed tabs, and how to override the templates/CSS** →
  [theming/nice_login.md](theming/nice_login.md)

Key facts:
- Alters `user_login_form`, `user_pass`, `user_register_form`; sets `#theme` to
  `nice_login__login` / `nice_login__pass` / `nice_login__register` and attaches `nice_login/form`.
- Tabs removed via `hook_preprocess_block()` blanking `local_tasks_block` on those three routes.
- "Create an account?" link honours `user.settings:register` (hidden when admin-only).
- Templates in `templates/nice-login--{login,pass,register}.html.twig`; CSS in `css/nice_login.css`.
