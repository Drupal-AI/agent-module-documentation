# Configuration

Home Redirect Language works with almost no setup — it attaches its cookie‑setting
JavaScript to the core Language Switcher automatically. There are, however, a
couple of things worth knowing and one optional setting.

## The first‑visit fallback

By design, the redirect relies on the `home_redirect_lang_preferred_langcode`
cookie, which only exists once a visitor has chosen a language. That means a
visitor's **very first** visit can't be redirected from the cookie.

To cover that case, the module's settings form offers a **"Fallback redirection
using visitor browser preferred language"** option. When enabled, the module falls
back to the language the visitor's *browser* prefers whenever the cookie is
absent. Turn it on if you want first‑time visitors sent to their likely language
straight away; leave it off if you'd rather only act on an explicit prior choice.

You'll find this option on the module's settings form in the **Configuration**
area after enabling the module.

## Required caching change (anonymous users)

For anonymous visitors, the redirect only works if core's **Internal Page Cache**
(`page_cache`) module is **disabled**. That cache assumes every anonymous user
receives an identical page regardless of cache contexts, which conflicts with a
per‑visitor redirect. Disable it:

```bash
drush pmu page_cache -y
```

See Drupal's note on
[internal page cache and cache contexts](https://www.drupal.org/docs/drupal-apis/cache-api/cache-contexts#internal)
for the background.

## Using a custom language switcher

By default the module attaches its JavaScript to Drupal's core Language Switcher
to create the preference cookie. If you use a **custom** switcher, you can drive
the cookie yourself instead:

1. Add the module's shared library to your theme:

   ```yaml
   libraries:
     - home_redirect_lang/common
   ```

2. In your own JavaScript, set the preferred language when a visitor picks one —
   for example on each language link's click:

   ```js
   // Guard in case the common library isn't present.
   if (typeof Drupal.homeRedirectLang !== "undefined") {
     Drupal.homeRedirectLang.setPreferredLanguage('fr');
   }
   ```

That stores the same `home_redirect_lang_preferred_langcode` cookie the redirect
looks for.

## Permission

The module provides its own permission. Review it at **People → Permissions** and
grant it to the appropriate roles.
