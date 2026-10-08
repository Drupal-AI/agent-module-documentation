# Configuration

Configuring Recombee is two jobs: entering your Recombee account credentials on
the settings form, then placing and tuning the tracker and recommendation blocks.

## 1. Enter your Recombee credentials

1. Log in as an administrator.
2. Open the Recombee settings form (route `recombee.settings`).
3. Enter the credentials Recombee gave you for your database. Recombee
   authenticates two ways, and the module needs both:
   - the **private** API credentials, used for indexing (pushing content) and
     other privileged operations, and
   - the **public** API credentials, used by the recommendation blocks to query
     for results from the browser.

   You will also identify the **Recombee database** these credentials belong to.
   The exact field labels follow Recombee's own terminology on the form; use the
   database identifier and tokens from your Recombee account.

### Keep the credentials out of committed config

The private token especially is a secret — anyone holding it can write to your
Recombee database. Do not commit it in exported configuration. Prefer supplying
it from an environment variable, and where the module accepts a
[Key](https://www.drupal.org/project/key) entity, store it there.

> **Using DDEV?** Save the value with `ddev dotenv set .ddev/.env
> --recombee-private-token=<value>` (the flag becomes the variable
> `RECOMBEE_PRIVATE_TOKEN`), then `ddev restart`. Never commit `.ddev/.env`.

## 2. Place the Recombee Tracker block

Go to **Structure → Block layout** and place the **Recombee Tracker** block.
Target it deliberately:

- Enable it only for the **content types** whose views should feed
  recommendations.
- Enable it only for the **roles** that represent normal site visitors. The
  maintainers recommend **not** tracking administrators, editors, or similar
  roles, whose browsing would pollute the behavioural signal.

The tracker sends visitor behaviour (views, clicks, identifiers) to Recombee.
Because that is personal data going to a third party, disclose it in your privacy
notice and, where required, gate the tracker behind visitor consent.

## 3. Place the Recombee Public Scenario blocks

Also on **Block layout**, place one or more **Recombee Public Scenario** blocks
where you want recommendations to appear. Each block instance has its own
options, including:

- the **scenario** (which Recombee recommendation scenario to request),
- the **number of items** to show, and
- the **template** used to transform the JSON result — pick the bundled "Recombee
  titles" template to start, or one your theme provides.

## Save and verify

Save the settings form and the block configuration, then view a front-end page as
a normal (tracked) role. Confirm the recommendation block renders results. If it
is empty at first, remember Recombee needs behavioural data and an indexed
content set before it can produce meaningful recommendations — this is where the
companion **Search API Recombee** module helps.

## Theming (optional)

Recommendation output is rendered by JSON Template's Handlebars transformer.
Themers can define their own Handlebars templates in the theme layer and select
them per block for output that matches the site's design.
