// Core In-Memory Application State & Sample MongoDB Seed Data
        const DB = {
            hotels: [
                {
                    id: "h1",
                    name: "The Grand Horizon Luxury Resort",
                    location: "Miami, FL",
                    rating: 4.9,
                    reviewsCount: 342,
                    pricePerNight: 299,
                    image: "https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=800&q=80",
                    description: "Experience world-class oceanfront dining, private beach access, infinity pool, and full luxury spa services.",
                    amenities: ["Pool", "Spa", "WiFi", "Breakfast"],
                    rooms: [
                        { id: "r1", name: "Deluxe Ocean View King", capacity: 2, price: 299, image: "https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80" },
                        { id: "r2", name: "Royal Executive Penthouse", capacity: 4, price: 540, image: "https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80" }
                    ]
                },
                {
                    id: "h2",
                    name: "Skyline Urban Boutique Hotel",
                    location: "New York, NY",
                    rating: 4.7,
                    reviewsCount: 215,
                    pricePerNight: 210,
                    image: "https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=800&q=80",
                    description: "Located right in Manhattan center. Panoramic rooftop cocktail bar, high-speed fiber internet, and sleek modern rooms.",
                    amenities: ["WiFi", "Breakfast"],
                    rooms: [
                        { id: "r3", name: "Manhattan View Studio", capacity: 2, price: 210, image: "https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=600&q=80" }
                    ]
                },
                {
                    id: "h3",
                    name: "Malibu Coastal Haven Villa",
                    location: "Malibu, CA",
                    rating: 4.8,
                    reviewsCount: 189,
                    pricePerNight: 450,
                    image: "https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80",
                    description: "Serene clifftop villa overlooking the Pacific Ocean. Features heated infinity pool and organic farm-to-table breakfast.",
                    amenities: ["Pool", "Spa", "WiFi", "Breakfast"],
                    rooms: [
                        { id: "r4", name: "Pacific Sunset Suite", capacity: 2, price: 450, image: "https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80" }
                    ]
                },
                {
                    id: "h4",
                    name: "Alpine Peak Lodge & Spa",
                    location: "Aspen, CO",
                    rating: 4.6,
                    reviewsCount: 128,
                    pricePerNight: 180,
                    image: "https://images.unsplash.com/photo-1518780664697-55e3ad937233?auto=format&fit=crop&w=800&q=80",
                    description: "Cosy ski-in/ski-out chalet with fireplace lounges, outdoor heated jacuzzi, and complimentary mountain shuttles.",
                    amenities: ["Spa", "WiFi"],
                    rooms: [
                        { id: "r5", name: "Alpine Fireplace Suite", capacity: 3, price: 180, image: "https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=600&q=80" }
                    ]
                }
            ],
            
            bookings: [
                {
                    bookingId: "BK-88391",
                    hotelId: "h1",
                    hotelName: "The Grand Horizon Luxury Resort",
                    roomName: "Deluxe Ocean View King",
                    guestName: "John Doe",
                    guestEmail: "john.doe@example.com",
                    checkIn: "Oct 12, 2026",
                    checkOut: "Oct 16, 2026",
                    totalPrice: 1339.52,
                    paymentMethod: "Credit Card (VISA)",
                    status: "Confirmed",
                    createdAt: "2026-09-20"
                }
            ],

            currentUser: {
                role: "guest",
                name: "John Doe",
                email: "john.doe@example.com"
            },

            selectedHotelForBooking: null,
            selectedRoomForBooking: null
        };

        function switchTab(tabId) {
            document.querySelectorAll('.tab-content').forEach(el => el.classList.add('hidden'));
            document.querySelectorAll('.tab-content').forEach(el => el.classList.remove('block'));
            
            const target = document.getElementById(`tab-${tabId}`);
            if (target) {
                target.classList.remove('hidden');
                target.classList.add('block');
            }

            // Update nav active styles
            document.querySelectorAll('.nav-btn').forEach(btn => {
                btn.classList.remove('text-white', 'bg-slate-800');
                btn.classList.add('text-slate-300');
            });

            const activeBtn = document.getElementById(`nav-${tabId}`);
            if (activeBtn) {
                activeBtn.classList.add('text-white', 'bg-slate-800');
            }

            // Render triggers based on tab
            if (tabId === 'hotels') renderHotelsList();
            if (tabId === 'my-bookings') renderMyBookings();
            if (tabId === 'admin') renderAdminDashboard();
            if (tabId === 'architecture') showCodeSnippet('payment.jsp');

            window.scrollTo({ top: 0, behavior: 'smooth' });
        }

        function renderFeaturedHotels() {
            const container = document.getElementById('featured-hotels-grid');
            if (!container) return;

            container.innerHTML = DB.hotels.slice(0, 3).map(hotel => `
                <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden shadow-sm hover:shadow-xl transition group">
                    <div class="relative h-48 overflow-hidden">
                        <img src="${hotel.image}" alt="${hotel.name}" class="w-full h-full object-cover group-hover:scale-105 transition duration-500">
                        <div class="absolute top-3 right-3 bg-slate-900/80 backdrop-blur-md text-white text-xs font-bold px-2.5 py-1 rounded-lg flex items-center gap-1">
                            <i data-lucide="star" class="w-3.5 h-3.5 text-amber-400 fill-amber-400"></i> ${hotel.rating}
                        </div>
                    </div>
                    <div class="p-5">
                        <span class="text-xs font-bold text-sky-600 uppercase tracking-wider">${hotel.location}</span>
                        <h3 class="font-bold text-slate-900 text-lg mt-0.5">${hotel.name}</h3>
                        <p class="text-slate-500 text-xs mt-2 line-clamp-2">${hotel.description}</p>
                        
                        <div class="mt-4 pt-4 border-t border-slate-100 flex items-center justify-between">
                            <div>
                                <span class="text-xl font-extrabold text-slate-900">$${hotel.pricePerNight}</span>
                                <span class="text-xs text-slate-400">/ night</span>
                            </div>
                            <button onclick="openHotelDetails('${hotel.id}')" class="px-3.5 py-2 bg-slate-900 hover:bg-sky-600 text-white font-bold rounded-xl text-xs transition">
                                View Details
                            </button>
                        </div>
                    </div>
                </div>
            `).join('');

            lucide.createIcons();
        }

        function renderHotelsList() {
            const container = document.getElementById('hotels-list-container');
            if (!container) return;

            const maxPrice = parseFloat(document.getElementById('filter-price').value);
            const minRating = parseFloat(document.querySelector('input[name="rating-filter"]:checked').value);
            const sortVal = document.getElementById('sort-select').value;

            // Selected amenities
            const selectedAmenities = Array.from(document.querySelectorAll('.amenity-checkbox:checked')).map(cb => cb.value);

            let filtered = DB.hotels.filter(h => {
                if (h.pricePerNight > maxPrice) return false;
                if (h.rating < minRating) return false;
                if (selectedAmenities.length > 0) {
                    const hasAll = selectedAmenities.every(a => h.amenities.includes(a));
                    if (!hasAll) return false;
                }
                return true;
            });

            // Sorting
            if (sortVal === 'price-low') filtered.sort((a,b) => a.pricePerNight - b.pricePerNight);
            if (sortVal === 'price-high') filtered.sort((a,b) => b.pricePerNight - a.pricePerNight);
            if (sortVal === 'rating') filtered.sort((a,b) => b.rating - a.rating);

            document.getElementById('results-count-text').innerText = `Showing ${filtered.length} of ${DB.hotels.length} hotels`;

            if (filtered.length === 0) {
                container.innerHTML = `
                    <div class="bg-white p-12 rounded-2xl text-center border border-slate-200">
                        <i data-lucide="search-x" class="w-12 h-12 text-slate-400 mx-auto mb-3"></i>
                        <h3 class="font-bold text-slate-800 text-base">No Hotels Match Your Filters</h3>
                        <p class="text-xs text-slate-500 mt-1">Try increasing your price slider or clearing selected amenities.</p>
                        <button onclick="resetFilters()" class="mt-4 px-4 py-2 bg-sky-600 text-white rounded-xl text-xs font-bold">Reset Filters</button>
                    </div>
                `;
                lucide.createIcons();
                return;
            }

            container.innerHTML = filtered.map(hotel => `
                <div class="bg-white rounded-2xl border border-slate-200 overflow-hidden shadow-sm hover:shadow-md transition flex flex-col md:flex-row">
                    <div class="md:w-72 h-52 md:h-auto relative flex-shrink-0">
                        <img src="${hotel.image}" class="w-full h-full object-cover">
                    </div>
                    <div class="p-6 flex-grow flex flex-col justify-between">
                        <div>
                            <div class="flex justify-between items-start">
                                <div>
                                    <span class="text-xs font-bold text-sky-600 uppercase">${hotel.location}</span>
                                    <h3 class="text-xl font-bold text-slate-900">${hotel.name}</h3>
                                </div>
                                <div class="bg-amber-50 border border-amber-200 px-2.5 py-1 rounded-lg text-xs font-bold text-amber-800 flex items-center gap-1">
                                    ★ ${hotel.rating} <span class="text-slate-400 text-[10px]">(${hotel.reviewsCount})</span>
                                </div>
                            </div>
                            <p class="text-slate-600 text-xs mt-2 leading-relaxed">${hotel.description}</p>
                            
                            <div class="flex flex-wrap gap-1.5 mt-3">
                                ${hotel.amenities.map(a => `<span class="px-2 py-0.5 bg-slate-100 text-slate-600 rounded text-[10px] font-semibold">${a}</span>`).join('')}
                            </div>
                        </div>

                        <div class="mt-5 pt-4 border-t border-slate-100 flex items-center justify-between">
                            <div>
                                <span class="text-2xl font-extrabold text-slate-900">$${hotel.pricePerNight}</span>
                                <span class="text-xs text-slate-400">/ night</span>
                            </div>
                            <button onclick="openHotelDetails('${hotel.id}')" class="px-5 py-2.5 bg-gradient-to-r from-sky-600 to-indigo-600 text-white font-bold text-xs rounded-xl hover:shadow-lg hover:shadow-sky-600/30 transition">
                                Select Room & Book
                            </button>
                        </div>
                    </div>
                </div>
            `).join('');

            lucide.createIcons();
        }

        function applyHotelFilters() {
            document.getElementById('price-value').innerText = `$${document.getElementById('filter-price').value}`;
            renderHotelsList();
        }

        function resetFilters() {
            document.getElementById('filter-price').value = 1000;
            document.querySelector('input[name="rating-filter"][value="0"]').checked = true;
            document.querySelectorAll('.amenity-checkbox').forEach(cb => cb.checked = false);
            applyHotelFilters();
        }

        function handleSearchSubmit(e) {
            e.preventDefault();
            switchTab('hotels');
            showToast('Searching database...', 'Filtered results applied based on check-in parameters.');
        }

        function openHotelDetails(hotelId) {
            const hotel = DB.hotels.find(h => h.id === hotelId);
            if (!hotel) return;

            DB.selectedHotelForBooking = hotel;
            const container = document.getElementById('hotel-details-container');

            container.innerHTML = `
                <div class="bg-white rounded-3xl shadow-xl border border-slate-200 overflow-hidden">
                    <div class="relative h-80">
                        <img src="${hotel.image}" class="w-full h-full object-cover">
                        <div class="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/30 to-transparent"></div>
                        <div class="absolute bottom-6 left-6 right-6 text-white">
                            <span class="px-3 py-1 bg-sky-500/80 backdrop-blur-md rounded-full text-xs font-bold">${hotel.location}</span>
                            <h1 class="text-3xl font-extrabold mt-2">${hotel.name}</h1>
                        </div>
                    </div>

                    <div class="p-6 sm:p-8 space-y-8">
                        <div>
                            <h3 class="font-bold text-lg text-slate-900 mb-2">About Property</h3>
                            <p class="text-sm text-slate-600 leading-relaxed max-w-3xl">${hotel.description}</p>
                        </div>

                        <div>
                            <h3 class="font-bold text-lg text-slate-900 mb-4">Available Rooms in DB</h3>
                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                ${hotel.rooms.map(room => `
                                    <div class="border border-slate-200 rounded-2xl overflow-hidden bg-slate-50 flex flex-col justify-between">
                                        <img src="${room.image}" class="w-full h-44 object-cover">
                                        <div class="p-5">
                                            <div class="flex justify-between items-start">
                                                <div>
                                                    <h4 class="font-bold text-slate-900 text-base">${room.name}</h4>
                                                    <span class="text-xs text-slate-500 font-medium">Capacity: ${room.capacity} Guests</span>
                                                </div>
                                                <div class="text-right">
                                                    <span class="text-xl font-extrabold text-slate-900">$${room.price}</span>
                                                    <span class="text-[10px] block text-slate-400">per night</span>
                                                </div>
                                            </div>

                                            <button onclick="startBookingProcess('${hotel.id}', '${room.id}')" class="mt-5 w-full py-2.5 bg-slate-900 hover:bg-sky-600 text-white font-bold text-xs rounded-xl transition shadow-md">
                                                Reserve This Room
                                            </button>
                                        </div>
                                    </div>
                                `).join('')}
                            </div>
                        </div>
                    </div>
                </div>
            `;

            switchTab('hotel-details');
            lucide.createIcons();
        }

        function startBookingProcess(hotelId, roomId) {
            const hotel = DB.hotels.find(h => h.id === hotelId);
            const room = hotel.rooms.find(r => r.id === roomId);

            DB.selectedHotelForBooking = hotel;
            DB.selectedRoomForBooking = room;

            const nights = 4;
            const roomTotal = room.price * nights;
            const tax = roomTotal * 0.12;
            const grandTotal = roomTotal + tax;

            document.getElementById('checkout-header-price').innerText = `$${grandTotal.toFixed(2)}`;
            document.getElementById('summary-room-cost').innerText = `$${roomTotal.toFixed(2)}`;
            document.getElementById('summary-tax-cost').innerText = `$${tax.toFixed(2)}`;
            document.getElementById('summary-grand-total').innerText = `$${grandTotal.toFixed(2)}`;

            document.getElementById('checkout-summary-details').innerHTML = `
                <div class="flex items-center gap-3">
                    <img src="${hotel.image}" class="w-12 h-12 rounded-lg object-cover">
                    <div>
                        <p class="font-bold text-slate-800">${hotel.name}</p>
                        <p class="text-slate-500">${room.name}</p>
                    </div>
                </div>
                <div class="pt-2 border-t border-slate-200">
                    <p class="font-semibold text-slate-700">Dates: Oct 12 - Oct 16 (4 Nights)</p>
                    <p class="text-slate-500">Guests: 2 Adults</p>
                </div>
            `;

            switchTab('booking');
        }

        function selectPaymentMethod(method) {
            document.querySelectorAll('.pay-method-btn').forEach(btn => {
                btn.classList.remove('border-sky-600', 'bg-sky-50/50', 'text-sky-800');
                btn.classList.add('border-slate-200', 'bg-white', 'text-slate-600');
            });

            const activeBtn = document.getElementById(`pay-tab-${method}`);
            if (activeBtn) {
                activeBtn.classList.remove('border-slate-200', 'bg-white', 'text-slate-600');
                activeBtn.classList.add('border-sky-600', 'bg-sky-50/50', 'text-sky-800');
            }

            document.getElementById('payment-form-card').classList.add('hidden');
            document.getElementById('payment-form-upi').classList.add('hidden');
            document.getElementById('payment-form-paypal').classList.add('hidden');
            document.getElementById('payment-form-netbanking').classList.add('hidden');

            document.getElementById(`payment-form-${method}`).classList.remove('hidden');
        }

        function processPayment() {
            const btn = document.getElementById('btn-pay-now');
            btn.disabled = true;
            btn.innerHTML = `<i data-lucide="loader-2" class="w-5 h-5 animate-spin"></i> Processing Transaction with MongoDB...`;
            lucide.createIcons();

            setTimeout(() => {
                const hotel = DB.selectedHotelForBooking || DB.hotels[0];
                const room = DB.selectedRoomForBooking || hotel.rooms[0];
                const nights = 4;
                const total = (room.price * nights) * 1.12;

                const newBooking = {
                    bookingId: "BK-" + Math.floor(10000 + Math.random() * 90000),
                    hotelId: hotel.id,
                    hotelName: hotel.name,
                    roomName: room.name,
                    guestName: document.getElementById('pay-guest-name').value || "John Doe",
                    guestEmail: document.getElementById('pay-guest-email').value || "john.doe@example.com",
                    checkIn: "Oct 12, 2026",
                    checkOut: "Oct 16, 2026",
                    totalPrice: parseFloat(total.toFixed(2)),
                    paymentMethod: "Credit Card (Processed)",
                    status: "Confirmed",
                    createdAt: new Date().toISOString().split('T')[0]
                };

                // Insert into in-memory DB array
                DB.bookings.unshift(newBooking);

                // Update Confirmation Voucher
                document.getElementById('conf-booking-id').innerText = "#" + newBooking.bookingId;
                document.getElementById('conf-hotel-name').innerText = newBooking.hotelName;
                document.getElementById('conf-room-name').innerText = newBooking.roomName;
                document.getElementById('conf-hotel-img').src = hotel.image;
                document.getElementById('conf-total').innerText = "$" + newBooking.totalPrice;
                document.getElementById('conf-txn-id').innerText = Math.floor(1000000000 + Math.random() * 9000000000);

                updateBookingBadgeCount();

                btn.disabled = false;
                btn.innerHTML = `<i data-lucide="lock" class="w-5 h-5"></i> Pay Now & Confirm Booking`;

                showToast('Payment Approved!', 'Reservation inserted into MongoDB bookings collection.');
                switchTab('confirmation');
            }, 1200);
        }

        function renderMyBookings() {
            const container = document.getElementById('my-bookings-list');
            if (!container) return;

            if (DB.bookings.length === 0) {
                container.innerHTML = `
                    <div class="bg-white p-10 rounded-2xl text-center border border-slate-200">
                        <p class="text-slate-500 text-sm">No reservations found for current user.</p>
                    </div>
                `;
                return;
            }

            container.innerHTML = DB.bookings.map(b => `
                <div class="bg-white p-5 rounded-2xl border border-slate-200 shadow-sm flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
                    <div class="flex items-center gap-4">
                        <div class="w-12 h-12 rounded-xl bg-sky-100 text-sky-600 flex items-center justify-center font-bold text-base flex-shrink-0">
                            <i data-lucide="hotel" class="w-6 h-6"></i>
                        </div>
                        <div>
                            <span class="text-[10px] font-mono bg-slate-100 px-2 py-0.5 rounded text-slate-600 font-bold">${b.bookingId}</span>
                            <h4 class="font-bold text-slate-900 text-base mt-0.5">${b.hotelName}</h4>
                            <p class="text-xs text-slate-500">${b.roomName} • ${b.checkIn} - ${b.checkOut}</p>
                        </div>
                    </div>

                    <div class="flex items-center gap-4 w-full md:w-auto justify-between border-t md:border-t-0 pt-3 md:pt-0">
                        <div class="text-right">
                            <span class="text-base font-extrabold text-slate-900">$${b.totalPrice}</span>
                            <span class="text-[10px] block text-emerald-600 font-bold">● ${b.status}</span>
                        </div>
                        <button onclick="cancelBooking('${b.bookingId}')" class="px-3.5 py-2 bg-red-50 hover:bg-red-100 text-red-600 font-bold text-xs rounded-xl transition">
                            Cancel
                        </button>
                    </div>
                </div>
            `).join('');

            lucide.createIcons();
        }

        function cancelBooking(bookingId) {
            DB.bookings = DB.bookings.filter(b => b.bookingId !== bookingId);
            updateBookingBadgeCount();
            renderMyBookings();
            showToast('Booking Cancelled', 'MongoDB document removed from database.');
        }

        function updateBookingBadgeCount() {
            document.getElementById('booking-badge-count').innerText = DB.bookings.length;
        }

        function renderAdminDashboard() {
            const table = document.getElementById('admin-bookings-table');
            if (!table) return;

            const totalRev = DB.bookings.reduce((sum, b) => sum + b.totalPrice, 12500);
            document.getElementById('admin-stat-revenue').innerText = `$${totalRev.toFixed(2)}`;
            document.getElementById('admin-stat-bookings').innerText = DB.bookings.length + 38;

            table.innerHTML = DB.bookings.map(b => `
                <tr class="hover:bg-slate-50">
                    <td class="p-3.5 font-mono font-bold text-sky-600">${b.bookingId}</td>
                    <td class="p-3.5 font-medium text-slate-800">${b.guestName}<br><span class="text-[10px] text-slate-400">${b.guestEmail}</span></td>
                    <td class="p-3.5 font-medium text-slate-800">${b.hotelName}<br><span class="text-[10px] text-slate-400">${b.roomName}</span></td>
                    <td class="p-3.5 text-slate-600">${b.checkIn}</td>
                    <td class="p-3.5 font-bold text-slate-900">$${b.totalPrice}</td>
                    <td class="p-3.5 text-emerald-600 font-semibold">${b.paymentMethod}</td>
                    <td class="p-3.5"><span class="px-2 py-0.5 bg-emerald-100 text-emerald-800 rounded-full font-bold text-[10px]">Confirmed</span></td>
                    <td class="p-3.5 text-right">
                        <button onclick="cancelBooking('${b.bookingId}'); renderAdminDashboard();" class="text-red-600 hover:text-red-800 font-bold">Delete DB Record</button>
                    </td>
                </tr>
            `).join('');
        }

        const CODE_SNIPPETS = {
            'index.jsp': `<%-- Online Hotel Reservation - Home Page (index.jsp) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>LuxeStay - Search Luxury Hotels</title>
</head>
<body>
    <h1>Welcome to LuxeStay Hotel Reservations</h1>
    <%
        // JSP direct connection to MongoDB database
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase db = mongoClient.getDatabase("hotelReservationDB");
        MongoCollection<Document> hotels = db.getCollection("hotels");
        
        for (Document hotel : hotels.find()) {
    %>
        <div class="hotel-card">
            <h3><%= hotel.getString("name") %></h3>
            <p>Location: <%= hotel.getString("location") %></p>
            <p>Price: $<%= hotel.getDouble("pricePerNight") %>/night</p>
            <a href="hotel-details.jsp?id=<%= hotel.getObjectId("_id") %>">View Details</a>
        </div>
    <%
        }
    %>
</body>
</html>`,

            'payment.jsp': `<%-- Online Hotel Reservation - Payment Gateway Handling (payment.jsp) --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mongodb.client.*, org.bson.Document, java.util.Date, java.util.UUID" %>
<%
    // Process payment parameters from checkout form
    String guestName = request.getParameter("guestName");
    String guestEmail = request.getParameter("guestEmail");
    String hotelName = request.getParameter("hotelName");
    double amountPaid = Double.parseDouble(request.getParameter("amount"));
    String paymentMethod = request.getParameter("paymentMethod");
    
    // Simulate Payment Gateway API Verification (Card/UPI/PayPal)
    boolean paymentSuccess = true; // Gateway handshake return
    
    if (paymentSuccess) {
        // Direct MongoDB Driver Sync
        MongoClient mongoClient = MongoClients.create("mongodb://localhost:27017");
        MongoDatabase database = mongoClient.getDatabase("hotelReservationDB");
        MongoCollection<Document> bookingsCol = database.getCollection("bookings");
        
        String bookingId = "BK-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
        
        Document newBookingDoc = new Document()
            .append("bookingId", bookingId)
            .append("guestName", guestName)
            .append("guestEmail", guestEmail)
            .append("hotelName", hotelName)
            .append("amountPaid", amountPaid)
            .append("paymentMethod", paymentMethod)
            .append("paymentStatus", "COMPLETED")
            .append("createdAt", new Date());
            
        bookingsCol.insertOne(newBookingDoc);
        
        response.sendRedirect("confirmation.jsp?bookingId=" + bookingId);
    } else {
        out.println("Payment Processing Failed. Please try again.");
    }
%>`,

            'mongo-bookings': `{
  "_id": { "$oid": "651a2b3c4d5e6f7a8b9c0d1e" },
  "bookingId": "BK-88391",
  "guestName": "John Doe",
  "guestEmail": "john.doe@example.com",
  "hotelName": "The Grand Horizon Luxury Resort",
  "roomName": "Deluxe Ocean View King",
  "checkIn": "2026-10-12",
  "checkOut": "2026-10-16",
  "amountPaid": 1339.52,
  "paymentMethod": "Credit Card (VISA)",
  "paymentStatus": "COMPLETED",
  "createdAt": { "$date": "2026-09-20T10:30:00Z" }
}`,

            'mongo-hotels': `{
  "_id": { "$oid": "651a1a1a1a1a1a1a1a1a1a1a" },
  "name": "The Grand Horizon Luxury Resort",
  "location": "Miami, FL",
  "rating": 4.9,
  "pricePerNight": 299.00,
  "amenities": ["Pool", "Spa", "WiFi", "Breakfast"],
  "rooms": [
    {
      "roomId": "r1",
      "name": "Deluxe Ocean View King",
      "price": 299.00,
      "capacity": 2
    }
  ]
}`
        };

        function showCodeSnippet(fileKey) {
            const viewer = document.getElementById('code-viewer-content');
            const title = document.getElementById('code-viewer-filename');

            if (CODE_SNIPPETS[fileKey]) {
                viewer.textContent = CODE_SNIPPETS[fileKey];
                title.innerHTML = `<i data-lucide="file-code" class="w-4 h-4"></i> ${fileKey}`;
            } else {
                viewer.textContent = `// JSP File: ${fileKey}\n// Integrated standard JSP template matching hotelReservationDB schema.`;
                title.innerHTML = `<i data-lucide="file-code" class="w-4 h-4"></i> ${fileKey}`;
            }
            lucide.createIcons();
        }

        function toggleUserModal() {
            document.getElementById('user-modal').classList.toggle('hidden');
        }

        function setUserRole(role) {
            DB.currentUser.role = role;
            if (role === 'admin') {
                DB.currentUser.name = "Admin Manager";
                document.getElementById('user-display-name').innerText = "Admin Manager";
                document.getElementById('avatar-initials').innerText = "AD";
                showToast("Admin Session Activated", "Switched to MongoDB Superuser view.");
            } else {
                DB.currentUser.name = "John Doe";
                document.getElementById('user-display-name').innerText = "John Doe";
                document.getElementById('avatar-initials').innerText = "JD";
                showToast("Guest Session", "Standard customer role selected.");
            }
            toggleUserModal();
        }

        function showToast(title, message) {
            const toast = document.getElementById('toast');
            document.getElementById('toast-title').innerText = title;
            document.getElementById('toast-msg').innerText = message;
            
            toast.classList.remove('translate-y-20', 'opacity-0');
            setTimeout(() => {
                toast.classList.add('translate-y-20', 'opacity-0');
            }, 3000);
        }

        window.onload = function() {
            lucide.createIcons();
            renderFeaturedHotels();
            updateBookingBadgeCount();
        };
