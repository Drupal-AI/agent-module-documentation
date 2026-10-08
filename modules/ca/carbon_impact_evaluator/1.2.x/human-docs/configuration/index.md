# Configuration

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Web services → Carbon Impact Evaluator Settings**.

## Settings

- **Activate the calculation plugins** — Enable the methodology (or methodologies)
  you want available on your site: **Sustainable Web Design**, **OneByte**, or both.
- **Green Host** — Indicate whether your site is hosted by a green host (one running
  on renewable energy). This affects the emissions estimate.
- **Datacentre Country** — If you activated the **Sustainable Web Design (Per Visit)**
  option, fill in the ISO alpha-3 country code (for example `FRA`, `USA`) of the
  country where your datacentre is located.

Save the settings form.

## Place the reporting block

The module provides a block that shows the carbon impact.

1. Go to **Structure → Block layout**.
2. Add the Carbon Impact Evaluator block to the region where you want it to appear.
3. In the block's configuration, open the **Pages** section and set it to **hide**
   the block on the following page:

   ```
   /carbon-impact-evaluator/table
   ```

   This prevents the module from running its calculations on the very page that
   displays the CO2 accounting table.

## View the results

Browse your site as normal, then open `/carbon-impact-evaluator/table` to see the
recorded carbon emissions per page. Only visits made after the module was installed
are counted.
