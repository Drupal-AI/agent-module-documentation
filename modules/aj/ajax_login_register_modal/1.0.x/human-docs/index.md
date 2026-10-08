# Ajax Login and Register Modal — manual setup guide

**Ajax Login and Register Modal** (`ajax_login_register_modal`) shows Drupal's
core login, registration and password-reset forms in an AJAX modal dialog. A
visitor can log in or register without navigating away from the page they are on,
which smooths the sign-in experience and can help conversion.

It is a **UX wrapper around core's own user forms** — it does not add its own
authentication logic and does not bypass core in any way. The forms it opens are
core's login/register/reset forms, so authentication, password handling and
login security all follow Drupal core exactly as they would on the normal
`/user/login`, `/user/register` and password-reset pages. The module provides
its own permission(s) to control who can use the modal behavior.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, the login, registration and password-reset forms open in a modal
dialog instead of loading a full page. Because it wraps core's forms, there is
no custom authentication to configure — the security model is core's. Review the
permission(s) the module adds on the **People → Permissions** page
(`/admin/people/permissions`) and grant them to the roles that should be able to
use the modal. See the [`agent/`](../agent/start.md) docs for orientation.
