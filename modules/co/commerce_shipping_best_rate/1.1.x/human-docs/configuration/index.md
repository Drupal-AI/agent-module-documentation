# Configuration

You configure Best Rate by adding a shipping method that uses the Best Rate
plugin, once for each group of services you want to collapse into a single
option.

## Create a best-rate shipping method

1. Go to **Commerce → Configuration → Shipping methods**
   (`/admin/commerce/shipping-methods`) and click **Add shipping method**.
2. Choose the **Best rate** plugin.
3. Fill in the fields:
   - **Rate label** — the text the customer sees. Make it describe the *group*,
     e.g. "Ground 3–5 days" or "Next Day Air". This label is shown in place of
     the individual services' names.
   - **Services to group** — select which of your existing shipping services
     belong in this group. At checkout the module compares their computed prices
     and keeps only the **lowest** one, displayed under your rate label.
   - **Rate description** *(optional)* — extra information shown to the customer,
     for example a cut-off time ("Order before 2pm for Next Day").
   - **Role options** — optionally disable grouping for chosen roles (so, say, a
     "Sales" role sees every individual rate), or show best-rate and regular
     rates together for selected roles.

Repeat for each group — for example one best-rate method for Ground, one for
Second Day, one for Next Day.

## Get the sort order right — this matters

The order of shipping methods on the list page is significant. **Each best-rate
method must be placed *after* the shipping methods that contain the services it
groups**, otherwise it will not appear and the grouped services will be missing
too.

A working order looks like this:

```
Flat rate
USPS
UPS
FedEx
Best rate - Ground
Best rate - Second day
Best rate - Next day
```

Drag the best-rate methods below the source methods on the shipping-methods
listing to achieve this.

## Save and test

Save the method(s), then run a test checkout. You should see your single,
friendly labels (priced at the cheapest service in each group) instead of the
raw list — unless you are logged in as a role you exempted from grouping.
