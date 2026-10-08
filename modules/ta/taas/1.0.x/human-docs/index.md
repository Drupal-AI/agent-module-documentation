# Tokens as a Service (TaaS) — manual setup guide

**Tokens as a Service** (`taas`) is a small developer helper that makes it cleaner
and more convenient to create custom Drupal *tokens*. Tokens are the
`[node:title]`-style placeholders that the Token module resolves into real values
throughout Drupal. Normally, defining your own token means writing a fair amount of
hook boilerplate; TaaS lets you define each token as a **service** instead, so the
plumbing stays out of your way and your custom data becomes available wherever
tokens are supported.

This is purely a **developer/API tool** — there is no admin screen, no settings
form, and nothing for a site builder to click. You use it by writing a small PHP
class and registering it in your module's `*.services.yml`. It depends on the
contributed **Token** module. It has no access-control role of its own: the tokens
you build resolve against whatever data you feed them, so that data should already
respect access.

Because there is nothing to configure in the UI, this guide is short — it just
covers installing and enabling the module, after which the work happens in your
own module's code.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (plus its Token dependency).

## How to use it

Once enabled, you define a token in two steps inside your own module:

1. **Write a token class** that implements `Drupal\taas\Token\TokenInterface` and
   returns the value from its `getValue()` method, for example:

   ```php
   namespace Drupal\my_module\Token;

   use Drupal\Component\Render\MarkupInterface;
   use Drupal\taas\Token\TokenInterface;

   class MyToken implements TokenInterface {
     public function getValue(array $data, array $options): MarkupInterface|string|null {
       return 'My token value';
     }
   }
   ```

2. **Register it as a service** in your module's `*.services.yml`, tagging it with
   `taas.token` and declaring the token's type, placeholder and title:

   ```yaml
   my_module.token.my_token:
     class: Drupal\my_module\Token\MyToken
     tags:
       - name: taas.token
         type: 'node'
         token: '[node:my-token]'
         title: 'My Token'
   ```

You can now use `[node:my-token]` anywhere tokens are supported.
