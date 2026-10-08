# Symfony Debug — manual setup guide

**Symfony Debug** (`symfony_debug`) replaces Drupal's default exception handler
with the error handler from the **Symfony ErrorHandler component**. The result
is much richer error pages while you develop: full stack traces, file paths,
code excerpts, and request/environment context, so tracking down what went wrong
is far quicker than with Drupal's default handling.

It works the moment you enable it — there is nothing to configure. There are no
other module dependencies and no third-party libraries; it simply swaps in the
Symfony debug handler on Drupal 9, 10, and 11.

**This module is for development and staging only — never enable it in
production.** The same detailed error page that helps you debug also displays
exactly the information a public site must not reveal: stack traces, your file
layout, snippets of code, and sometimes configuration or data caught in the
trace. On a live site that is a serious **information-disclosure** problem — it
hands an attacker a map of your code and infrastructure. Keep it strictly in
non-production environments, and confirm it is disabled before any deployment to
production. As defence in depth, pair it with Drupal's production error-display
setting so that errors are hidden from users regardless.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (in a development environment only).

## How to use it

Once enabled in your local or staging environment, trigger an error and you will
see Symfony's detailed error page in place of Drupal's usual white screen or
generic message — with the exception details, stack trace, and code context laid
out to make the cause obvious. There is no settings form: enabling the module is
the whole setup. When you are finished debugging, disable it again, and make
absolutely sure it is off wherever the site is publicly reachable.
