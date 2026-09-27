<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="h-full bg-slate-50">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LuxeStay - Online Hotel Reservation System</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Plus Jakarta Sans', 'sans-serif'],
                    },
                    colors: {
                        brand: {
                            50: '#f0f7ff',
                            100: '#e0effe',
                            500: '#0284c7',
                            600: '#0265d2',
                            700: '#0369a1',
                            800: '#075985',
                            900: '#0c4a6e',
                        }
                    }
                }
            }
        }
    </script>
    <link rel="stylesheet" href="css/style.css">
</head><body class="font-sans antialiased text-slate-800 h-full flex flex-col bg-slate-50 min-h-screen">

    <!-- Top Navigation -->
    <header class="bg-slate-900 text-white sticky top-0 z-40 border-b border-slate-800 shadow-md no-print">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex items-center justify-between h-16">
                <!-- Brand Logo -->
                <div class="flex items-center space-x-3 cursor-pointer" onclick="switchTab('home')">
                    <div class="bg-gradient-to-tr from-sky-500 to-indigo-600 p-2.5 rounded-xl shadow-lg text-white">
                        <i data-lucide="hotel" class="w-6 h-6"></i>
                    </div>
                    <div>
                        <span class="text-xl font-extrabold tracking-tight bg-gradient-to-r from-white via-sky-100 to-sky-400 bg-clip-text text-transparent">LuxeStay</span>
                        <span class="text-[10px] block font-mono text-sky-400 uppercase tracking-widest -mt-1">JSP + MongoDB Architecture</span>
                    </div>
                </div>

                <!-- Main Nav Links -->
                <nav class="hidden md:flex space-x-1 lg:space-x-2">
                    <button onclick="switchTab('home')" id="nav-home" class="nav-btn px-3 py-2 rounded-lg text-sm font-semibold text-slate-300 hover:text-white hover:bg-slate-800 transition flex items-center gap-1.5 active-nav">
                        <i data-lucide="compass" class="w-4 h-4"></i> Explore
                    </button>
                    <button onclick="switchTab('hotels')" id="nav-hotels" class="nav-btn px-3 py-2 rounded-lg text-sm font-semibold text-slate-300 hover:text-white hover:bg-slate-800 transition flex items-center gap-1.5">
                        <i data-lucide="search" class="w-4 h-4"></i> Search Hotels
                    </button>
                    <button onclick="switchTab('my-bookings')" id="nav-my-bookings" class="nav-btn px-3 py-2 rounded-lg text-sm font-semibold text-slate-300 hover:text-white hover:bg-slate-800 transition flex items-center gap-1.5 relative">
                        <i data-lucide="calendar" class="w-4 h-4"></i> My Bookings
                        <span id="booking-badge-count" class="bg-sky-500 text-white text-xs px-1.5 py-0.5 rounded-full font-bold">0</span>
                    </button>
                    <button onclick="switchTab('admin')" id="nav-admin" class="nav-btn px-3 py-2 rounded-lg text-sm font-semibold text-amber-400 hover:text-amber-300 hover:bg-slate-800 transition flex items-center gap-1.5">
                        <i data-lucide="shield-check" class="w-4 h-4"></i> Admin Panel
                    </button>
                    <button onclick="switchTab('architecture')" id="nav-architecture" class="nav-btn px-3.5 py-2 rounded-lg text-sm font-semibold bg-sky-950 text-sky-300 border border-sky-800/60 hover:bg-sky-900 transition flex items-center gap-1.5">
                        <i data-lucide="code-2" class="w-4 h-4 text-sky-400"></i> Project & DB Explorer
                    </button>
                </nav>

                <!-- User Profile & Action -->
                <div class="flex items-center gap-3">
                    <div id="user-pill" class="flex items-center gap-2 bg-slate-800 hover:bg-slate-700/80 px-3 py-1.5 rounded-full text-xs font-medium border border-slate-700 cursor-pointer transition" onclick="toggleUserModal()">
                        <div class="w-6 h-6 rounded-full bg-gradient-to-r from-sky-400 to-indigo-500 text-slate-900 font-bold flex items-center justify-center text-xs" id="avatar-initials">
                            JD
                        </div>
                        <span id="user-display-name" class="text-slate-200 hidden sm:inline">John Doe</span>
                        <i data-lucide="chevron-down" class="w-3.5 h-3.5 text-slate-400"></i>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- User Switcher / Auth Simulation Modal -->
    <div id="user-modal" class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm z-50 hidden flex items-center justify-center p-4 no-print">
        <div class="bg-white rounded-2xl max-w-md w-full p-6 shadow-2xl border border-slate-100">
            <div class="flex justify-between items-center pb-4 border-b">
                <h3 class="text-lg font-bold text-slate-900 flex items-center gap-2">
                    <i data-lucide="user" class="text-sky-600"></i> Account Authentication
                </h3>
                <button onclick="toggleUserModal()" class="text-slate-400 hover:text-slate-600 p-1">
                    <i data-lucide="x" class="w-5 h-5"></i>
                </button>
            </div>
            <div class="mt-4 space-y-3">
                <p class="text-xs text-slate-500">Switch user role to test MongoDB permissions and JSP session states:</p>
                
                <div onclick="setUserRole('guest')" id="role-guest" class="p-3.5 rounded-xl border-2 border-slate-200 hover:border-sky-500 cursor-pointer flex items-center justify-between transition bg-slate-50 hover:bg-sky-50/30">
                    <div class="flex items-center gap-3">
                        <div class="w-9 h-9 rounded-full bg-sky-100 text-sky-600 font-bold flex items-center justify-center">
                            JD
                        </div>
                        <div>
                            <p class="font-bold text-sm text-slate-800">John Doe (Guest User)</p>
                            <p class="text-xs text-slate-500">Standard customer booking experience</p>
                        </div>
                    </div>
                    <i data-lucide="check-circle" class="w-5 h-5 text-sky-600 hidden" id="check-guest"></i>
                </div>

                <div onclick="setUserRole('admin')" id="role-admin" class="p-3.5 rounded-xl border-2 border-slate-200 hover:border-amber-500 cursor-pointer flex items-center justify-between transition bg-slate-50 hover:bg-amber-50/30">
                    <div class="flex items-center gap-3">
                        <div class="w-9 h-9 rounded-full bg-amber-100 text-amber-700 font-bold flex items-center justify-center">
                            AD
                        </div>
                        <div>
                            <p class="font-bold text-sm text-slate-800">Admin Manager</p>
                            <p class="text-xs text-slate-500">Full access to backend MongoDB dashboard</p>
                        </div>
                    </div>
                    <i data-lucide="check-circle" class="w-5 h-5 text-amber-600 hidden" id="check-admin"></i>
                </div>
            </div>
            <button onclick="toggleUserModal()" class="w-full mt-5 bg-slate-900 text-white font-semibold py-2.5 rounded-xl hover:bg-slate-800 transition">
                Apply Session
            </button>
        </div>
    </div>

    <!-- Toast Notification Banner -->
    <div id="toast" class="fixed bottom-5 right-5 z-50 transform translate-y-20 opacity-0 transition-all duration-300 max-w-sm bg-slate-900 text-white p-4 rounded-xl shadow-2xl border border-slate-700 flex items-center gap-3 no-print">
        <div id="toast-icon" class="p-2 rounded-lg bg-emerald-500/20 text-emerald-400">
            <i data-lucide="check-circle" class="w-5 h-5"></i>
        </div>
        <div>
            <h4 id="toast-title" class="font-bold text-sm text-white">Success</h4>
            <p id="toast-msg" class="text-xs text-slate-300">Action performed successfully</p>
        </div>
    </div>

    <!-- MAIN CONTENT CONTAINER -->
    <main class="flex-grow">

        <!-- TAB 1: HOME PAGE (index.jsp equivalent) -->
        <section id="tab-home" class="tab-content block">
            <!-- Hero Section -->
            <div class="relative bg-slate-900 text-white overflow-hidden py-16 sm:py-24">
                <div class="absolute inset-0 opacity-25">
                    <img src="https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1800&q=80" alt="Luxury Resort background" class="w-full h-full object-cover">
                </div>
                <div class="absolute inset-0 bg-gradient-to-t from-slate-900 via-slate-900/60 to-transparent"></div>

                <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center sm:text-left">
                    <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-sky-500/20 text-sky-300 border border-sky-500/30 mb-4">
                        <i data-lucide="sparkles" class="w-3.5 h-3.5"></i> Premium Stays & Instant Confirmation
                    </span>
                    <h1 class="text-3xl sm:text-5xl font-extrabold tracking-tight leading-tight max-w-2xl">
                        Find & Book Your Next Extraordinary Hotel
                    </h1>
                    <p class="mt-4 text-base sm:text-lg text-slate-300 max-w-xl">
                        Discover top-rated luxury resorts, boutique suites, and business hotels with instant payment processing and instant MongoDB database reservation sync.
                    </p>

                    <!-- Search Box Widget -->
                    <div class="mt-8 bg-white p-4 sm:p-6 rounded-2xl shadow-2xl text-slate-800 border border-slate-100 max-w-5xl">
                        <form onsubmit="handleSearchSubmit(event)" class="grid grid-cols-1 md:grid-cols-4 gap-4 items-end">
                            <!-- Destination -->
                            <div class="text-left">
                                <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1">Destination</label>
                                <div class="relative">
                                    <i data-lucide="map-pin" class="w-4 h-4 absolute left-3 top-3 text-slate-400"></i>
                                    <select id="search-destination" class="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm focus:ring-2 focus:ring-sky-500 focus:outline-none font-medium text-slate-700">
                                        <option value="All">All Locations</option>
                                        <option value="Miami, FL">Miami, FL</option>
                                        <option value="New York, NY">New York, NY</option>
                                        <option value="Malibu, CA">Malibu, CA</option>
                                        <option value="Aspen, CO">Aspen, CO</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Check-In / Out -->
                            <div class="text-left">
                                <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1">Dates</label>
                                <div class="relative">
                                    <i data-lucide="calendar" class="w-4 h-4 absolute left-3 top-3 text-slate-400"></i>
                                    <input type="text" id="search-dates" value="Oct 12 - Oct 16" class="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm focus:ring-2 focus:ring-sky-500 focus:outline-none font-medium text-slate-700">
                                </div>
                            </div>

                            <!-- Guests -->
                            <div class="text-left">
                                <label class="block text-xs font-bold text-slate-500 uppercase tracking-wider mb-1">Guests & Rooms</label>
                                <div class="relative">
                                    <i data-lucide="users" class="w-4 h-4 absolute left-3 top-3 text-slate-400"></i>
                                    <select id="search-guests" class="w-full pl-9 pr-3 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm focus:ring-2 focus:ring-sky-500 focus:outline-none font-medium text-slate-700">
                                        <option value="1">1 Guest, 1 Room</option>
                                        <option value="2" selected>2 Guests, 1 Room</option>
                                        <option value="4">4 Guests, 2 Rooms</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Submit button -->
                            <div>
                                <button type="submit" class="w-full bg-gradient-to-r from-sky-600 to-indigo-600 hover:from-sky-500 hover:to-indigo-500 text-white font-bold py-2.5 rounded-xl shadow-lg shadow-sky-600/30 transition flex items-center justify-center gap-2">
                                    <i data-lucide="search" class="w-4 h-4"></i> Find Hotels
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Featured Hotels Grid -->
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
                <div class="flex items-center justify-between mb-8">
                    <div>
                        <h2 class="text-2xl font-bold text-slate-900">Featured Luxury Stays</h2>
                        <p class="text-sm text-slate-500">Handpicked premium properties with verified MongoDB records</p>
                    </div>
                    <button onclick="switchTab('hotels')" class="text-sky-600 hover:text-sky-700 font-semibold text-sm flex items-center gap-1">
                        View All Hotels <i data-lucide="arrow-right" class="w-4 h-4"></i>
                    </button>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-6" id="featured-hotels-grid">
                    <!-- Dynamic rendering via JS -->
                </div>
            </div>
        </section>

        <!-- TAB 2: HOTELS LISTING & SEARCH (hotels.jsp equivalent) -->
        <section id="tab-hotels" class="tab-content hidden max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="flex flex-col md:flex-row gap-8">
                <!-- Sidebar Filters -->
                <div class="w-full md:w-64 flex-shrink-0">
                    <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200 sticky top-20 space-y-6">
                        <div class="flex items-center justify-between pb-3 border-b">
                            <h3 class="font-bold text-slate-900 text-sm flex items-center gap-2">
                                <i data-lucide="sliders-horizontal" class="w-4 h-4 text-sky-600"></i> Filters
                            </h3>
                            <button onclick="resetFilters()" class="text-xs text-sky-600 hover:underline font-medium">Reset</button>
                        </div>

                        <!-- Price Range Filter -->
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase mb-2">Max Price per Night</label>
                            <input type="range" id="filter-price" min="100" max="1000" step="50" value="1000" oninput="applyHotelFilters()" class="w-full accent-sky-600">
                            <div class="flex justify-between text-xs text-slate-500 mt-1 font-semibold">
                                <span>$100</span>
                                <span id="price-value" class="text-sky-600 font-bold">$1000</span>
                            </div>
                        </div>

                        <!-- Minimum Rating Filter -->
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase mb-2">Minimum Rating</label>
                            <div class="space-y-1.5">
                                <label class="flex items-center gap-2 text-xs text-slate-600 cursor-pointer">
                                    <input type="radio" name="rating-filter" value="0" checked onchange="applyHotelFilters()" class="accent-sky-600"> Any Rating
                                </label>
                                <label class="flex items-center gap-2 text-xs text-slate-600 cursor-pointer">
                                    <input type="radio" name="rating-filter" value="4.5" onchange="applyHotelFilters()" class="accent-sky-600"> ★ 4.5 & above (Top Rated)
                                </label>
                                <label class="flex items-center gap-2 text-xs text-slate-600 cursor-pointer">
                                    <input type="radio" name="rating-filter" value="4.0" onchange="applyHotelFilters()" class="accent-sky-600"> ★ 4.0 & above
                                </label>
                            </div>
                        </div>

                        <!-- Amenities Filter -->
                        <div>
                            <label class="block text-xs font-bold text-slate-700 uppercase mb-2">Amenities</label>
                            <div class="space-y-2 text-xs text-slate-600">
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" value="Pool" class="amenity-checkbox accent-sky-600" onchange="applyHotelFilters()"> Swimming Pool
                                </label>
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" value="Spa" class="amenity-checkbox accent-sky-600" onchange="applyHotelFilters()"> Luxury Spa
                                </label>
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" value="WiFi" class="amenity-checkbox accent-sky-600" onchange="applyHotelFilters()"> Free High-Speed WiFi
                                </label>
                                <label class="flex items-center gap-2 cursor-pointer">
                                    <input type="checkbox" value="Breakfast" class="amenity-checkbox accent-sky-600" onchange="applyHotelFilters()"> Free Breakfast
                                </label>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Main Listing Content -->
                <div class="flex-grow">
                    <!-- Search Header & Sorting -->
                    <div class="bg-white p-4 rounded-2xl shadow-sm border border-slate-200 mb-6 flex flex-wrap justify-between items-center gap-4">
                        <div>
                            <h2 class="text-xl font-extrabold text-slate-900">Available Hotels</h2>
                            <p class="text-xs text-slate-500" id="results-count-text">Showing all properties</p>
                        </div>
                        <div class="flex items-center gap-2">
                            <span class="text-xs font-bold text-slate-500 uppercase">Sort By:</span>
                            <select id="sort-select" onchange="applyHotelFilters()" class="bg-slate-50 border border-slate-200 text-xs rounded-lg px-3 py-2 font-medium focus:outline-none">
                                <option value="recommended">Recommended</option>
                                <option value="price-low">Price: Low to High</option>
                                <option value="price-high">Price: High to Low</option>
                                <option value="rating">Highest Rated</option>
                            </select>
                        </div>
                    </div>

                    <!-- Hotel List Container -->
                    <div id="hotels-list-container" class="space-y-6">
                        <!-- Rendered via JS -->
                    </div>
                </div>
            </div>
        </section>

        <!-- TAB 3: HOTEL DETAILS (hotel-details.jsp equivalent) -->
        <section id="tab-hotel-details" class="tab-content hidden max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <button onclick="switchTab('hotels')" class="mb-4 text-xs font-bold text-sky-600 hover:text-sky-800 flex items-center gap-1">
                <i data-lucide="arrow-left" class="w-4 h-4"></i> Back to Search Results
            </button>

            <div id="hotel-details-container">
                <!-- Dynamically populated -->
            </div>
        </section>

        <!-- TAB 4: BOOKING & PAYMENT GATEWAY (booking.jsp + payment integration) -->
        <section id="tab-booking" class="tab-content hidden max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="bg-white rounded-3xl shadow-xl border border-slate-200 overflow-hidden">
                <div class="bg-slate-900 text-white p-6 sm:p-8 flex flex-wrap justify-between items-center gap-4">
                    <div>
                        <span class="text-xs font-mono text-sky-400 uppercase tracking-widest block mb-1">Step 2 of 3: Checkout</span>
                        <h2 class="text-2xl font-bold">Complete Your Reservation</h2>
                    </div>
                    <div class="text-right">
                        <span class="text-xs text-slate-400 block">Total Amount</span>
                        <span id="checkout-header-price" class="text-2xl font-extrabold text-emerald-400">$0</span>
                    </div>
                </div>

                <div class="p-6 sm:p-8 grid grid-cols-1 lg:grid-cols-3 gap-8">
                    <!-- Left: Guest Info & Payment Form -->
                    <div class="lg:col-span-2 space-y-6">
                        <!-- Guest Information -->
                        <div>
                            <h3 class="text-base font-bold text-slate-900 mb-3 flex items-center gap-2">
                                <i data-lucide="user-check" class="w-5 h-5 text-sky-600"></i> Guest Details
                            </h3>
                            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-xs font-bold text-slate-600 mb-1">Full Name</label>
                                    <input type="text" id="pay-guest-name" value="John Doe" class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium focus:ring-2 focus:ring-sky-500 focus:outline-none">
                                </div>
                                <div>
                                    <label class="block text-xs font-bold text-slate-600 mb-1">Email Address</label>
                                    <input type="email" id="pay-guest-email" value="john.doe@example.com" class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium focus:ring-2 focus:ring-sky-500 focus:outline-none">
                                </div>
                                <div class="sm:col-span-2">
                                    <label class="block text-xs font-bold text-slate-600 mb-1">Phone Number</label>
                                    <input type="tel" id="pay-guest-phone" value="+1 (555) 234-5678" class="w-full px-3.5 py-2.5 bg-slate-50 border border-slate-200 rounded-xl text-sm font-medium focus:ring-2 focus:ring-sky-500 focus:outline-none">
                                </div>
                            </div>
                        </div>

                        <!-- Integrated Payment Method Selection -->
                        <div>
                            <h3 class="text-base font-bold text-slate-900 mb-3 flex items-center gap-2">
                                <i data-lucide="credit-card" class="w-5 h-5 text-sky-600"></i> Payment Gateway
                            </h3>
                            
                            <!-- Payment Tabs -->
                            <div class="grid grid-cols-4 gap-2 mb-4">
                                <button type="button" onclick="selectPaymentMethod('card')" id="pay-tab-card" class="pay-method-btn p-3 text-center border-2 border-sky-600 bg-sky-50/50 rounded-xl text-xs font-bold text-sky-800 transition">
                                    <i data-lucide="credit-card" class="w-4 h-4 mx-auto mb-1"></i> Card
                                </button>
                                <button type="button" onclick="selectPaymentMethod('upi')" id="pay-tab-upi" class="pay-method-btn p-3 text-center border-2 border-slate-200 bg-white rounded-xl text-xs font-bold text-slate-600 hover:border-slate-300 transition">
                                    <i data-lucide="qr-code" class="w-4 h-4 mx-auto mb-1"></i> UPI / QR
                                </button>
                                <button type="button" onclick="selectPaymentMethod('paypal')" id="pay-tab-paypal" class="pay-method-btn p-3 text-center border-2 border-slate-200 bg-white rounded-xl text-xs font-bold text-slate-600 hover:border-slate-300 transition">
                                    <i data-lucide="wallet" class="w-4 h-4 mx-auto mb-1"></i> PayPal
                                </button>
                                <button type="button" onclick="selectPaymentMethod('netbanking')" id="pay-tab-netbanking" class="pay-method-btn p-3 text-center border-2 border-slate-200 bg-white rounded-xl text-xs font-bold text-slate-600 hover:border-slate-300 transition">
                                    <i data-lucide="landmark" class="w-4 h-4 mx-auto mb-1"></i> NetBank
                                </button>
                            </div>

                            <!-- Payment Form Fields -->
                            <div id="payment-form-card" class="p-4 bg-slate-50 border border-slate-200 rounded-2xl space-y-4">
                                <div>
                                    <label class="block text-xs font-bold text-slate-600 mb-1">Cardholder Name</label>
                                    <input type="text" value="JOHN DOE" class="w-full px-3.5 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-medium focus:ring-2 focus:ring-sky-500 uppercase">
                                </div>
                                <div>
                                    <label class="block text-xs font-bold text-slate-600 mb-1">Card Number</label>
                                    <div class="relative">
                                        <input type="text" value="4532 •••• •••• 8892" class="w-full px-3.5 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-mono tracking-wider focus:ring-2 focus:ring-sky-500">
                                        <span class="absolute right-3 top-3 text-xs font-bold text-slate-400">VISA</span>
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-xs font-bold text-slate-600 mb-1">Expiry Date</label>
                                        <input type="text" value="08 / 28" class="w-full px-3.5 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-mono focus:ring-2 focus:ring-sky-500">
                                    </div>
                                    <div>
                                        <label class="block text-xs font-bold text-slate-600 mb-1">CVV Code</label>
                                        <input type="password" value="•••" class="w-full px-3.5 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-mono focus:ring-2 focus:ring-sky-500">
                                    </div>
                                </div>
                            </div>

                            <div id="payment-form-upi" class="p-4 bg-slate-50 border border-slate-200 rounded-2xl hidden text-center space-y-3">
                                <p class="text-xs text-slate-600">Scan QR Code or Enter Virtual Payment Address (VPA)</p>
                                <div class="w-32 h-32 bg-white border border-slate-300 rounded-xl mx-auto flex items-center justify-center shadow-inner">
                                    <i data-lucide="qr-code" class="w-24 h-24 text-slate-800"></i>
                                </div>
                                <input type="text" placeholder="username@upi" value="johndoe@okaxis" class="w-full max-w-xs px-3.5 py-2 bg-white border border-slate-200 rounded-xl text-xs font-mono text-center">
                            </div>

                            <div id="payment-form-paypal" class="p-4 bg-slate-50 border border-slate-200 rounded-2xl hidden text-center space-y-2">
                                <p class="text-xs text-slate-600">Redirecting to PayPal Sandbox express checkout...</p>
                                <div class="p-3 bg-amber-50 border border-amber-200 rounded-xl text-amber-800 font-bold text-sm">
                                    Pay with PayPal One-Click
                                </div>
                            </div>

                            <div id="payment-form-netbanking" class="p-4 bg-slate-50 border border-slate-200 rounded-2xl hidden space-y-2">
                                <label class="block text-xs font-bold text-slate-600">Select Bank</label>
                                <select class="w-full px-3.5 py-2.5 bg-white border border-slate-200 rounded-xl text-sm font-medium">
                                    <option>Chase Bank / J.P. Morgan</option>
                                    <option>Bank of America</option>
                                    <option>Wells Fargo</option>
                                    <option>Citi Bank</option>
                                </select>
                            </div>
                        </div>

                        <!-- Processing Button -->
                        <button onclick="processPayment()" id="btn-pay-now" class="w-full py-4 bg-gradient-to-r from-emerald-600 to-teal-600 hover:from-emerald-500 hover:to-teal-500 text-white font-extrabold rounded-2xl shadow-xl shadow-emerald-600/20 text-base transition flex items-center justify-center gap-2">
                            <i data-lucide="lock" class="w-5 h-5"></i> Pay Now & Confirm Booking
                        </button>
                    </div>

                    <!-- Right: Summary Sidebar -->
                    <div class="bg-slate-50 p-5 rounded-2xl border border-slate-200 h-fit space-y-4">
                        <h3 class="font-bold text-slate-900 border-b pb-2 text-sm">Booking Summary</h3>
                        
                        <div id="checkout-summary-details" class="space-y-3 text-xs text-slate-600">
                            <!-- Populated via JS -->
                        </div>

                        <div class="border-t pt-3 space-y-1.5 text-xs">
                            <div class="flex justify-between text-slate-600">
                                <span>Room Rate (4 nights)</span>
                                <span id="summary-room-cost">$0</span>
                            </div>
                            <div class="flex justify-between text-slate-600">
                                <span>Taxes & Hotel Fees (12%)</span>
                                <span id="summary-tax-cost">$0</span>
                            </div>
                            <div class="flex justify-between font-bold text-slate-900 text-sm border-t pt-2">
                                <span>Grand Total</span>
                                <span id="summary-grand-total" class="text-sky-600">$0</span>
                            </div>
                        </div>

                        <div class="bg-sky-50 p-3 rounded-xl border border-sky-100 flex items-start gap-2 text-[11px] text-sky-800">
                            <i data-lucide="shield-check" class="w-4 h-4 text-sky-600 flex-shrink-0 mt-0.5"></i>
                            <span>Protected by 256-bit SSL encryption & direct MongoDB transaction log.</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- TAB 5: CONFIRMATION VOUCHER (confirmation.jsp equivalent) -->
        <section id="tab-confirmation" class="tab-content hidden max-w-3xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
            <div class="bg-white rounded-3xl shadow-2xl border border-slate-200 overflow-hidden text-center p-8 relative">
                <!-- Success icon -->
                <div class="w-20 h-20 bg-emerald-100 text-emerald-600 rounded-full mx-auto flex items-center justify-center shadow-inner mb-4">
                    <i data-lucide="check-circle-2" class="w-12 h-12"></i>
                </div>

                <span class="text-xs font-extrabold uppercase tracking-widest text-emerald-600 bg-emerald-50 px-3 py-1 rounded-full border border-emerald-200">
                    Payment Successful & MongoDB Saved
                </span>

                <h1 class="text-2xl sm:text-3xl font-extrabold text-slate-900 mt-3">Booking Confirmed!</h1>
                <p class="text-xs sm:text-sm text-slate-500 max-w-md mx-auto mt-1">
                    Your reservation details have been stored in the <code class="bg-slate-100 px-1 py-0.5 rounded text-sky-700">bookings</code> collection.
                </p>

                <!-- Printable Voucher Card -->
                <div class="mt-8 bg-slate-50 p-6 rounded-2xl border border-slate-200 text-left space-y-4 relative overflow-hidden" id="voucher-card">
                    <div class="absolute top-0 right-0 bg-slate-900 text-white text-[10px] uppercase font-mono px-4 py-1 rounded-bl-xl">
                        Official Hotel Voucher
                    </div>

                    <div class="flex items-center gap-4 pb-4 border-b border-slate-200">
                        <img id="conf-hotel-img" class="w-16 h-16 rounded-xl object-cover shadow-sm">
                        <div>
                            <h3 id="conf-hotel-name" class="font-extrabold text-slate-900 text-lg">Hotel Name</h3>
                            <p id="conf-room-name" class="text-xs font-semibold text-sky-600">Room Name</p>
                        </div>
                    </div>

                    <div class="grid grid-cols-2 sm:grid-cols-4 gap-4 text-xs">
                        <div>
                            <span class="text-slate-400 block font-bold uppercase text-[10px]">Booking ID</span>
                            <span id="conf-booking-id" class="font-mono font-bold text-slate-800">#BK-9021</span>
                        </div>
                        <div>
                            <span class="text-slate-400 block font-bold uppercase text-[10px]">Check-In</span>
                            <span id="conf-checkin" class="font-bold text-slate-800">Oct 12, 2026</span>
                        </div>
                        <div>
                            <span class="text-slate-400 block font-bold uppercase text-[10px]">Check-Out</span>
                            <span id="conf-checkout" class="font-bold text-slate-800">Oct 16, 2026</span>
                        </div>
                        <div>
                            <span class="text-slate-400 block font-bold uppercase text-[10px]">Payment Paid</span>
                            <span id="conf-total" class="font-bold text-emerald-600">$0</span>
                        </div>
                    </div>

                    <!-- Barcode simulation -->
                    <div class="pt-4 border-t border-slate-200 flex items-center justify-between">
                        <div class="font-mono text-[10px] text-slate-400">
                            TRANSACTION ID: TXN_<span id="conf-txn-id">8849201948</span>
                        </div>
                        <div class="flex space-x-1 h-8 opacity-70">
                            <div class="w-1 bg-slate-800 h-full"></div>
                            <div class="w-2 bg-slate-800 h-full"></div>
                            <div class="w-0.5 bg-slate-800 h-full"></div>
                            <div class="w-1.5 bg-slate-800 h-full"></div>
                            <div class="w-1 bg-slate-800 h-full"></div>
                            <div class="w-3 bg-slate-800 h-full"></div>
                        </div>
                    </div>
                </div>

                <div class="mt-6 flex flex-wrap gap-3 justify-center">
                    <button onclick="window.print()" class="px-5 py-2.5 bg-slate-900 text-white rounded-xl text-xs font-bold hover:bg-slate-800 transition flex items-center gap-2">
                        <i data-lucide="printer" class="w-4 h-4"></i> Print Voucher
                    </button>
                    <button onclick="switchTab('my-bookings')" class="px-5 py-2.5 bg-sky-600 text-white rounded-xl text-xs font-bold hover:bg-sky-500 transition flex items-center gap-2">
                        <i data-lucide="list font-bold" class="w-4 h-4"></i> View My Bookings
                    </button>
                </div>
            </div>
        </section>

        <!-- TAB 6: MY BOOKINGS (my-bookings.jsp equivalent) -->
        <section id="tab-my-bookings" class="tab-content hidden max-w-5xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="flex items-center justify-between mb-6">
                <div>
                    <h2 class="text-2xl font-extrabold text-slate-900">My Reservations</h2>
                    <p class="text-xs text-slate-500">Live query result from MongoDB <code class="bg-slate-200 px-1 rounded">users.bookings</code></p>
                </div>
                <button onclick="switchTab('hotels')" class="px-4 py-2 bg-sky-600 text-white rounded-xl text-xs font-bold hover:bg-sky-500 transition">
                    + Book New Hotel
                </button>
            </div>

            <div id="my-bookings-list" class="space-y-4">
                <!-- Rendered dynamically -->
            </div>
        </section>

        <!-- TAB 7: ADMIN DASHBOARD (admin/dashboard.jsp equivalent) -->
        <section id="tab-admin" class="tab-content hidden max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="bg-amber-50 border border-amber-200 rounded-2xl p-4 mb-6 flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <div class="p-2 bg-amber-500 text-white rounded-xl">
                        <i data-lucide="shield-alert" class="w-5 h-5"></i>
                    </div>
                    <div>
                        <h4 class="font-bold text-sm text-amber-900">Admin Control Panel Mode</h4>
                        <p class="text-xs text-amber-700">Simulating full CRUD control over MongoDB `hotelReservationDB` collections</p>
                    </div>
                </div>
                <span class="text-xs font-mono bg-amber-200/80 text-amber-900 px-2.5 py-1 rounded-full font-bold">Admin Active</span>
            </div>

            <!-- Analytics Stats Overview -->
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
                <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200">
                    <span class="text-xs font-bold text-slate-500 uppercase">Total Revenue</span>
                    <h3 id="admin-stat-revenue" class="text-2xl font-extrabold text-slate-900 mt-1">$14,280</h3>
                    <span class="text-[10px] text-emerald-600 font-bold flex items-center gap-1 mt-1">
                        <i data-lucide="trending-up" class="w-3 h-3"></i> +18.4% from last month
                    </span>
                </div>
                <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200">
                    <span class="text-xs font-bold text-slate-500 uppercase">Total Reservations</span>
                    <h3 id="admin-stat-bookings" class="text-2xl font-extrabold text-slate-900 mt-1">42</h3>
                    <span class="text-[10px] text-sky-600 font-bold flex items-center gap-1 mt-1">
                        <i data-lucide="check-circle" class="w-3 h-3"></i> Live MongoDB Sync
                    </span>
                </div>
                <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200">
                    <span class="text-xs font-bold text-slate-500 uppercase">Hotels Listed</span>
                    <h3 id="admin-stat-hotels" class="text-2xl font-extrabold text-slate-900 mt-1">4</h3>
                    <span class="text-[10px] text-slate-400 font-bold mt-1 block">Active in Collection</span>
                </div>
                <div class="bg-white p-5 rounded-2xl shadow-sm border border-slate-200">
                    <span class="text-xs font-bold text-slate-500 uppercase">Occupancy Rate</span>
                    <h3 class="text-2xl font-extrabold text-indigo-600 mt-1">86.4%</h3>
                    <span class="text-[10px] text-slate-400 font-bold mt-1 block">Optimal capacity</span>
                </div>
            </div>

            <!-- Admin Bookings Data Table -->
            <div class="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden">
                <div class="p-4 bg-slate-900 text-white flex justify-between items-center">
                    <h3 class="font-bold text-sm flex items-center gap-2">
                        <i data-lucide="database" class="w-4 h-4 text-amber-400"></i> All Database Bookings (`bookings` collection)
                    </h3>
                    <span class="text-xs text-slate-400 font-mono">DB: hotelReservationDB</span>
                </div>

                <div class="overflow-x-auto">
                    <table class="w-full text-left text-xs text-slate-600">
                        <thead class="bg-slate-50 text-slate-700 font-bold uppercase border-b border-slate-200">
                            <tr>
                                <th class="p-3.5">Booking ID</th>
                                <th class="p-3.5">Guest</th>
                                <th class="p-3.5">Hotel & Room</th>
                                <th class="p-3.5">Dates</th>
                                <th class="p-3.5">Amount</th>
                                <th class="p-3.5">Payment</th>
                                <th class="p-3.5">Status</th>
                                <th class="p-3.5 text-right">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="admin-bookings-table" class="divide-y divide-slate-100">
                            <!-- Populated via JS -->
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

        <!-- TAB 8: ARCHITECTURE & MONGO DB SCHEMA VIEWER -->
        <section id="tab-architecture" class="tab-content hidden max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
            <div class="bg-slate-900 rounded-3xl shadow-2xl text-white overflow-hidden border border-slate-800">
                <div class="p-6 border-b border-slate-800 flex flex-wrap justify-between items-center gap-4">
                    <div>
                        <div class="flex items-center gap-2">
                            <span class="px-2.5 py-1 bg-sky-500/20 text-sky-400 text-xs font-mono font-bold rounded border border-sky-500/30">
                                JSP + MongoDB Direct Architecture
                            </span>
                        </div>
                        <h2 class="text-2xl font-extrabold mt-2">Project Files & Database Schemas</h2>
                    </div>
                </div>

                <div class="grid grid-cols-1 lg:grid-cols-3 min-h-[550px]">
                    <!-- Left: Interactive File Tree -->
                    <div class="bg-slate-950 p-4 border-r border-slate-800 text-xs font-mono space-y-1 custom-scrollbar overflow-y-auto">
                        <p class="text-slate-500 font-bold mb-3 uppercase tracking-wider text-[11px]">📁 Project Directory Tree</p>
                        
                        <div class="pl-2 space-y-1">
                            <div class="text-sky-400 font-bold flex items-center gap-1.5"><i data-lucide="folder-open" class="w-3.5 h-3.5"></i> OnlineHotelReservation/</div>
                            
                            <div onclick="showCodeSnippet('index.jsp')" class="pl-5 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-slate-300 flex items-center gap-1.5 font-sans hover:text-white">
                                <i data-lucide="file-code" class="w-3.5 h-3.5 text-sky-400"></i> index.jsp
                            </div>
                            <div onclick="showCodeSnippet('hotels.jsp')" class="pl-5 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-slate-300 flex items-center gap-1.5 font-sans hover:text-white">
                                <i data-lucide="file-code" class="w-3.5 h-3.5 text-sky-400"></i> hotels.jsp
                            </div>
                            <div onclick="showCodeSnippet('booking.jsp')" class="pl-5 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-slate-300 flex items-center gap-1.5 font-sans hover:text-white">
                                <i data-lucide="file-code" class="w-3.5 h-3.5 text-sky-400"></i> booking.jsp
                            </div>
                            <div onclick="showCodeSnippet('payment.jsp')" class="pl-5 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-slate-300 flex items-center gap-1.5 font-sans hover:text-white">
                                <i data-lucide="file-code" class="w-3.5 h-3.5 text-emerald-400"></i> payment.jsp
                            </div>

                            <div class="pl-5 py-1 text-slate-400 font-bold flex items-center gap-1.5"><i data-lucide="folder" class="w-3.5 h-3.5"></i> MongoDB Collections /</div>
                            <div onclick="showCodeSnippet('mongo-bookings')" class="pl-8 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-amber-300 flex items-center gap-1.5 font-mono">
                                <i data-lucide="database" class="w-3.5 h-3.5 text-amber-400"></i> bookings.json
                            </div>
                            <div onclick="showCodeSnippet('mongo-hotels')" class="pl-8 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-amber-300 flex items-center gap-1.5 font-mono">
                                <i data-lucide="database" class="w-3.5 h-3.5 text-amber-400"></i> hotels.json
                            </div>

                            <div class="pl-5 py-1 text-slate-400 font-bold flex items-center gap-1.5"><i data-lucide="folder" class="w-3.5 h-3.5"></i> WEB-INF /</div>
                            <div onclick="showCodeSnippet('web.xml')" class="pl-8 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-slate-300 flex items-center gap-1.5 font-mono">
                                <i data-lucide="file-text" class="w-3.5 h-3.5"></i> web.xml
                            </div>
                            <div onclick="showCodeSnippet('pom.xml')" class="pl-5 py-1 hover:bg-slate-800/80 rounded cursor-pointer text-slate-300 flex items-center gap-1.5 font-mono">
                                <i data-lucide="file-text" class="w-3.5 h-3.5"></i> pom.xml
                            </div>
                        </div>
                    </div>

                    <!-- Right: Code & Document Viewer -->
                    <div class="lg:col-span-2 p-6 bg-slate-900 custom-scrollbar overflow-y-auto">
                        <div class="flex justify-between items-center pb-3 border-b border-slate-800 mb-4">
                            <span id="code-viewer-filename" class="font-mono text-sm font-bold text-sky-400 flex items-center gap-2">
                                <i data-lucide="file-code" class="w-4 h-4"></i> booking.jsp (Payment Processing & DB Insert)
                            </span>
                            <span class="text-xs text-slate-500 font-mono">Syntax Highlighted Preview</span>
                        </div>
                        <pre id="code-viewer-content" class="text-xs font-mono text-slate-300 bg-slate-950 p-4 rounded-xl border border-slate-800 overflow-x-auto whitespace-pre leading-relaxed">
                        </pre>
                    </div>
                </div>
            </div>
        </section>

    </main>
    <script src="js/app.js"></script>
</body>