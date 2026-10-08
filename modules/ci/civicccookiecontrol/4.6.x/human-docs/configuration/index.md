# Configuration

Cookie Control needs configuration before it does anything useful — at minimum your
CIVIC API key. Getting the categories right (and making your scripts respect them)
is the difference between real compliance and a decorative banner.

## Open the settings form

1. Log in as a user with the **Administer Civic Cookie Control** permission (an
   administrator).
2. Go to **Configuration → Civic Cookie Control**.

## Connect your CIVIC API key

Enter the **API key** you obtained from CIVIC UK for this site. Without a valid key
the Cookie Control widget will not initialise.

> **Keep the key out of plain config.** Rather than committing the key into exported
> configuration, prefer an environment variable. With DDEV you can store it with
> `ddev dotenv set .ddev/.env --cookiecontrol-api-key=<value>` and `ddev restart`,
> then reference it (for example via a [Key](https://www.drupal.org/project/key)
> entity or `getenv()`), so the secret never lands in your repository.

## Define your consent categories

Cookie Control organises cookies into **categories** (also called purposes) that
the visitor can accept or decline — for example necessary, analytics, marketing.
Configure the categories your site actually uses, with clear descriptions, so the
consent UI reflects reality. This is also where you tune the widget's behaviour and
appearance to match your site.

## The critical step: make your scripts respect consent

This is what most sites miss. Defining categories and showing a banner does **not**
by itself stop cookies from being set. You must ensure that each script which sets
non-essential cookies — analytics, marketing tags, third-party embeds — only runs
**after** the visitor has consented to the matching category. Cookie Control
provides the mechanism to gate scripts by category; wiring your actual scripts into
it is a configuration job you must complete.

Practical approach:

1. Run a cookie audit so you know which scripts set which cookies.
2. Assign each script to the correct consent category.
3. Gate the script so it only fires once that category is consented to.
4. Test with a clean session: decline a category and confirm its cookies are **not**
   set; accept it and confirm they then appear.

## GOV.UK variant

If you enabled the `civic_govuk_cookiecontrol` submodule, it applies the DWP GOV.UK
consent pattern (including removing cookies when consent is withdrawn). Follow
CIVIC's GOV.UK configuration guidance for the exact category and behaviour setup.

## Save

Save the form, then verify on the front end with a fresh browser session that the
banner appears and that declining a category truly prevents its cookies from being
set.
