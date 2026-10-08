# Configuration

Configuring Cron Timing is a two-step affair: first you define the intervals you
want on the module's own form, then you pick one on the core Cron settings page.

## Step 1 — Add your intervals

1. Log in as a user with the **Administer administration pages** permission (an
   administrator by default — this is the permission that gates the form).
2. Go to **Configuration → System → Cron Timing**, or navigate directly to
   `/admin/config/system/cron_timing`.
3. In the single text field, enter the intervals you want as a **comma-separated
   list of seconds**. For example:

   ```
   60,120,360,900
   ```

   That adds options for 1 minute, 2 minutes, 6 minutes, and 15 minutes. The field
   is pre-populated with the module's defaults, `300,900` (5 and 15 minutes).

   The input is validated to allow only digits separated by commas — no spaces,
   letters, or other characters — so stick to plain second values.
4. Click **Save configuration**. The values are stored in exportable configuration,
   so they travel with your config between environments.

## Step 2 — Choose the interval for cron

1. Go to **Configuration → System → Cron** (`/admin/config/system/cron`).
2. In the **Run cron every** dropdown you'll now see your custom intervals
   alongside core's built-in ones, each shown as a friendly label (minutes, hours,
   or days).
3. Select the interval you want and **Save configuration**.

## Removing or changing intervals

To drop an interval, go back to the Cron Timing form and edit the comma-separated
list — remove the value and save. To return to just the module defaults, set the
field back to `300,900`.
