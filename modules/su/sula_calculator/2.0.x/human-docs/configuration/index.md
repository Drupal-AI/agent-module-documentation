# Configuration

Setting up the calculator is a two-part job: place the block(s) where you want
the tool to appear, and tune the calculator's parameters on the settings form.

## Place the calculator blocks

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region where you want the calculator, click **Place block**.
3. Choose either the **SULA credit calculator** or the **SULA clock/time
   calculator** block (you can place both, in the same or different regions).
4. Use the standard block configuration to restrict where it shows — by path, by
   content type, or by role — then save.

You can place the calculator on as many pages as you like by repeating this for
each region or by using the block's visibility conditions. A good spot is
alongside enrollment or financial-aid content, so students can estimate their
eligibility in context.

## Tune the calculator's parameters

1. Log in as a user with the **Administer SULA calculator** permission (an
   administrator by default).
2. Go to **Configuration → System → SULA Calculator**, or navigate directly to
   `/admin/config/system/sula_calculator`.

This settings form is where you adjust the values that drive the estimate — the
academic-year length variables and the calculator's labels and options. Change
them to match how your institution measures subsidized usage, then save the
form. The two blocks read these settings, so a change here updates the tool
everywhere it is placed.

## Save

Click **Save configuration** on the settings form. Reload a page where you placed
a calculator block and try it out — enter values and the result is computed via
AJAX, without reloading the page.
