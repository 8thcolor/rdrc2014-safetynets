# RDRC 2014: Safety Nets: learn to code with confidence

This repository contains the code illustrating the talk given by me
(Christophe Philemotte) at RedDotRubyConference 2014: Safety Nets: Learn to
code with confidence.

Each commit corresponds to a step in the illustration and will allow you to
reproduce it step by step.

## A simple invoicing application

As illustration, we'll implement a simple invoicing application. This is a
common use case that everybody should easily relate to. Please consider that
it's not a real application. It's oversimplified as the goal is to support the
concept of safety nets without digging too deep in each kind of. As
consequence, some design could be certainly be improved.

## Test

### A simple invoice

An invoice is composed of several items in a certain quantity and with a
certain price. You can add an item to an invoice. You can get the total
of an invoice.

### Promote total local variable to member attribute

Then, we think it would be better to make total local variable a member
attribute.

But the test fails. We miss something when doing the change.

```
  1) Failure:
Invoice#test_0003_returns a correct total even after updating a previously added item [spec/invoice_spec.rb:30]:
Expected: 105
  Actual: 195.0
```

### Fix the failure

We miss to reset the total before calculate it. By doing it, the tests then
pass again.

## Static Analysis

### Manage European VAT

Then, as the invoice application is mainly used by Europeans, we decide to
manage VAT. We add then the necessary logic for: we need a country code and a
VAT rate.

### Complexity

With Flog we can detect that our very naive implementation is complicated,
i.e. it's hard to understand, then to change.

```
$ flog lib/invoice.rb 
    27.4: flog total
     5.5: flog/method average

    17.2: Invoice#total                    lib/invoice.rb:13

```

### A quote

We need now to issue quote as some customers would like to know the price
before purchasing. A quote is very similar to an invoice except that we
set the total in advance and it doesn't have items.

### Duplication

Copy-pasting is acceptable when working on an implementation. Eventually,
we need to get rid of any duplicates. It's something we can easily forget.
Thanks to Flay, we stay aware of all the duplicates present in the
codebase.

```
$ flay lib
Total score (lower is better) = 116

1) IDENTICAL code found in :if (mass*2 = 116)
  lib/invoice.rb:21
  lib/quote.rb:10
```

### A little refactoring

We decide to extract the calculation of the subtotal, before removing the
duplicates. We do that by adding a dedicated private method. The tests
are green.

### But tests don't catch everything

In the new method, we did a few errors that we can detect with `ruby -w`:

```
$ ruby -w lib/invoice.rb 
lib/invoice.rb:41: warning: shadowing outer local variable - total
lib/invoice.rb:40: warning: assigned but unused variable - total
```

Rubocop can also detect those problems and even more:

```
$ rubocop lib/invoice.rb 
Inspecting 1 file
W

Offenses:

lib/invoice.rb:1:1: C: Missing top-level class documentation comment.
class Invoice
^^^^^
lib/invoice.rb:13:3: C: Method has too many lines. [14/10]
  def total
  ^^^
lib/invoice.rb:18:11: C: Use %w or %W for array of words.
    elsif ['IT','FR','NL','LU','DE'].include?(@country_code)
          ^^^^^^^^^^^^^^^^^^^^^^^^^^
lib/invoice.rb:18:16: C: Space missing after comma.
    elsif ['IT','FR','NL','LU','DE'].include?(@country_code)
               ^
lib/invoice.rb:18:21: C: Space missing after comma.
    elsif ['IT','FR','NL','LU','DE'].include?(@country_code)
                    ^
lib/invoice.rb:18:26: C: Space missing after comma.
    elsif ['IT','FR','NL','LU','DE'].include?(@country_code)
                         ^
lib/invoice.rb:18:31: C: Space missing after comma.
    elsif ['IT','FR','NL','LU','DE'].include?(@country_code)
                              ^
lib/invoice.rb:40:5: W: Useless assignment to variable - total.
    total = 0
    ^^^^^
lib/invoice.rb:41:26: W: Shadowing outer local variable - total.
    @items.reduce(0) do |total, item|
                         ^^^^^
lib/invoice.rb:42:7: W: Useless assignment to variable - total. Use just operator +.
      total += item.price * item.quantity
      ^^^^^

1 file inspected, 10 offenses detected
```

### Let's fix already some flaws detected by Rubocop

Thanks to Rubocop, we can make the code better. Less risk of bug.

```
$ rubocop lib/invoice.rb 
Inspecting 1 file
C

Offenses:

lib/invoice.rb:1:1: C: Missing top-level class documentation comment.
class Invoice
^^^^^
lib/invoice.rb:13:3: C: Method has too many lines. [14/10]
  def total
  ^^^

1 file inspected, 2 offenses detected
```
