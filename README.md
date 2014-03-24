SALES TAXES

The code was developed using Ruby 1.8.7 under Mac OS X Leopard

For testing I used rspec 1.30 and rcov 0.9.8 for coverage.

The examples can be found at the end of printable_receipt_spec.rb

Besides the business rules for taxes in the problem write up, I used the sample output to determine the likely rules for other cases. For instance should import and sales taxes be calculated on a per line item basis or at the end of the purchase. Given the sample output it seemed clear that it was a per line basis.

I assumed that had there been more than one of a type of item purchased at a time (e.g. 2 music CDs) that the multiplication of costs for that line item, including import and domestic taxes should be done afterwards, because 1) that would give the government the greatest taxes due to round up and 2) that could generate the same total if a book, then a CD and then a book were purchases. This would be something worth clarifying with the customer and changing in the next iteration, had the assumptions been wrong.

I assumed that the extra space between 'book' and ':' in the example output for Output 1 was a typo. Were I able to talk with the customer I could clarify that. Were I wrong in that assumption, we could clarify the business rules as to when the space should and shouldn't be before ':' and fix that in the next iteration. 

I assumed however that the placement of 'imported' in the front of Output 3 was deliberate, so I handled that case.

I did not handle all kinds of error conditions that could arise from bad input. I assumed that in a real world situation, data on the purchase items would actually be stored in a database of some sort and that input would be just to select the right one either on line in a Rails app through pull down selections or at a checkout counter through a bar code reader. Accordingly I just assumed perfect text input as a simulation and parsed it to pull out the components that would have otherwise have been stored.

I didn't differentiate between food, medicine and books, because from a tax point of view, all the app cared about is whether it was tax able and how. I used a very simple decision logic to handle that, because again in the real world that would likely have been something determined when entering inventory into the database.