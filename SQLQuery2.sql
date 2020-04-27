-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

select firstName, lastName, customerId, country
from Customer
where country != 'USA'

-- brazil_customers.sql: Provide a query only showing the Customers from Brazil.

select *
from Customer
where country = 'Brazil'

-- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. 
-- The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

select CONCAT(Customer.firstName, ' ', Customer.LastName) as FullName, Invoice.InvoiceDate, Invoice.InvoiceDate, Invoice.BillingCountry
from Customer
	join Invoice
	on Customer.CustomerId = Invoice.CustomerId
	where country = 'Brazil'

-- sales_agents.sql`: Provide a query showing only the Employees who are Sales Agents.

select *
from Employee
where Employee.Title like 'Sales Support%'

-- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

select distinct Invoice.BillingCountry
from Invoice

-- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent.
-- The resultant table should include the Sales Agent's full name.

select CONCAT(Employee.FirstName, Employee.LastName) as FullName, Invoice.InvoiceId
from Employee
	join Customer on Customer.SupportRepId = Employee.EmployeeId
	join Invoice on Invoice.InvoiceId = Customer.CustomerId

-- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

select CONCAT(Customer.FirstName, ' ', Customer.LastName) as CustomerName, CONCAT(Employee.FirstName, ' ', Employee.LastName) as SalesAgent, Invoice.BillingCountry, Invoice.Total
from Invoice
	join Customer on Customer.customerId = Invoice.customerId
	join Employee on Employee.EmployeeId = Customer.SupportRepId

-- total_invoices_year.sql: How many Invoices were there in 2009 and 2011?

SELECT
(SELECT COUNT(*) FROM Invoice WHERE Year(Invoice.InvoiceDate) = 2009)+
(SELECT COUNT(*) from Invoice WHERE Year(Invoice.InvoiceDate) = 2011)
AS Total_Count_2009_and_2011

-- total_sales_year.sql: What are the respective total sales for each of those years?

Select YEAR(Invoice.InvoiceDate) as Year, SUM(Invoice.Total) as Total
From Invoice
group by Year(Invoice.InvoiceDate)
having Year(Invoice.InvoiceDate) in (2009, 2011)

 -- invoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

select COUNT(*) as LineItems
from invoiceline
where invoiceId = 37

-- line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice.

select count(*) as number_of_lines
from invoiceLine
group by InvoiceLine.InvoiceId

-- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

select Track.Name as TrackName
from Track
	join InvoiceLine
		on Track.TrackId = InvoiceLine.TrackId
			
-- line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

select Track.Name as TrackName, Artist.Name
from Track
	join Album
		on Track.AlbumId = Album.AlbumId
			join Artist
				on Album.ArtistId = Artist.ArtistId

-- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

select Invoice.BillingCountry as Country, count(*) as number_of_invoices
from invoice
group by invoice.BillingCountry

-- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. 
-- The Playlist name should be include on the resultant table.

select Playlist.Name as PlaylistName, Count(*) as number_of_tracks
from Playlist
	join PlaylistTrack
		on Playlist.PlaylistId = PlaylistTrack.PlaylistId
			group by Playlist.Name

-- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. 
-- The result should include the Album name, Media type and Genre.

select Track.Name as TrackName, Album.Title as AlbumName, MediaType.Name as MediaType, Genre.Name as GenreName
from Track
	join Album
	on Track.AlbumId = Album.AlbumId
		join MediaType
		on Track.MediaTypeId = MediaType.MediaTypeId
			join Genre
			on Track.GenreId = Genre.GenreId

-- sales_agent_total_sales.sql`: Provide a query that shows total sales made by each sales agent.

select Concat(Employee.Firstname, ' ', Employee.LastName) as SalesAgent, Sum(Invoice.Total) as TotalSales
from Employee
	join Customer
	on Employee.EmployeeId = Customer.SupportRepId
		join Invoice
		on Customer.CustomerId = Invoice.CustomerId
		group by concat(Employee.FirstName, ' ', Employee.LastName)

-- top_2009_agent.sql`: Which sales agent made the most in sales in 2009? HINT: [TOP]

select top 1 concat(employee.firstname, ' ', employee.lastname) as SalesAgent, Sum(invoice.total) as TotalSales
from Employee
	join customer
	on employee.employeeId = customer.SupportRepId
		join invoice
		on customer.customerId = invoice.CustomerId
		where Year(Invoice.InvoiceDate) = (2009)
		group by concat(Employee.firstName, ' ', Employee.lastname)

-- top_agent.sql: Which sales agent made the most in sales over all?

select top 1 concat(employee.firstname, ' ', employee.lastname) as SalesAgent, Sum(invoice.total) as TotalSales
from Employee
	join customer
	on employee.employeeId = customer.SupportRepId
		join invoice
		on customer.customerId = invoice.CustomerId
		group by concat(Employee.firstName, ' ', Employee.lastname)

-- sales_agent_customer_count.sql`: Provide a query that shows the count of customers assigned to each sales agent.

select concat(employee.firstname, ' ', employee.lastname) as SalesAgent, count(*) as Customers
from employee 
	join customer 
	on employee.EmployeeId = customer.SupportRepId
	group by concat(employee.firstname, ' ', employee.lastname)

-- sales_per_country.sql: Provide a query that shows the total sales per country.

select Invoice.BillingCountry as Country, Sum(Invoice.Total) as TotalSales
from Invoice
group by Invoice.BillingCountry

-- top_country.sql: Which country's customers spent the most?

select top 1 Sum(Invoice.Total) as TotalSales, Invoice.BillingCountry as Country
from Invoice
group by Invoice.BillingCountry
order by Invoice.BillingCountry desc

-- top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

select distinct Track.Name as TrackName, Invoice.Total as TotalPurchased
from Track
	join InvoiceLine
	on Track.TrackId = InvoiceLine.TrackId
		join Invoice
		on InvoiceLine.InvoiceId = Invoice.InvoiceId
			where Year(Invoice.InvoiceDate) = (2013)
			order by Invoice.Total desc

-- top_5_tracks.sql: Provide a query that shows the top 5 most purchased songs.

select distinct top 5 Track.Name as TrackName, Invoice.Total as TotalPurchased
from Track
	join InvoiceLine
	on Track.TrackId = InvoiceLine.TrackId
		join Invoice
		on InvoiceLine.InvoiceId = Invoice.InvoiceId
			order by Invoice.Total desc

-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists

select distinct top 3 Artist.Name as ArtistName, Invoice.Total as TotalPurchased
from Artist
	join Album
	on Artist.ArtistId = Album.ArtistId
		join Track
		on Album.ArtistId = Track.AlbumId
			join InvoiceLine
			on Track.TrackId = InvoiceLine.TrackId
				join Invoice
				on InvoiceLine.InvoiceId = Invoice.InvoiceId
					order by Invoice.Total desc

-- top_media_type.sql`: Provide a query that shows the most purchased Media Type.

select distinct top 1 MediaType.Name as [MediaName], Invoice.Total as TotalPurchased
from MediaType
		join Track
		on MediaType.MediaTypeId = Track.MediaTypeId
			join InvoiceLine
			on Track.TrackId = InvoiceLine.TrackId
				join Invoice
				on InvoiceLine.InvoiceId = Invoice.InvoiceId
					order by Invoice.Total desc

-- Last 3 need to be redone, they aren't correct.
