# FareCalc Travel Optimizer — small CLI for estimating ride fare
# Author: internal demo / assignment
# NOTE: uses floats; for real billing you'd use Decimal + banker's rounding

import sys

# --- config (rates tweaked by "ops" from time to time) ---
SURGE_START = 17  # 5pm
SURGE_END = 20    # 8pm window — product wanted inclusive end, so 17..20
SURGE_MULT = 1.5

# dict is fine here; list of allowed types kept separate because we validate messier input
rates_per_km = {
    "Economy": 12,
    "Premium": 18,
    "SUV": 25,
}

ALLOWED = ("Economy", "Premium", "SUV")


def normalize_vehicle_type(raw):
    """Messy user strings -> one of ALLOWED. Not fancy, just works."""
    s = raw.strip()
    if not s:
        return None
    low = s.lower()
    if low == "suv":
        return "SUV"
    # title-case works for economy/premium but breaks suv, handled above
    return s[0].upper() + s[1:].lower()


def calculate_fare(km, vehicle_type, hour):
    """
    Returns (base_fare, surge_applied_bool, final_fare).
    Surge applies in evening slot (see SURGE_* globals).
    """
    if vehicle_type not in rates_per_km:
        # raising here so main can catch — could also return None tuple but this is clearer
        raise ValueError("Invalid vehicle type. Pick one of: Economy, Premium, SUV.")

    rate = rates_per_km[vehicle_type]
    base_fare = km * rate

    # surge window — using chained compare; some people write hour >= 17 and hour <= 20 instead
    is_surge = SURGE_START <= hour <= SURGE_END
    if is_surge:
        final = base_fare * SURGE_MULT
    else:
        final = base_fare  # no copy-paste * 1.0 on purpose, looks silly

    return base_fare, is_surge, final


def print_receipt(km, vehicle_type, base_fare, surge, final_fare):
    # mixing format styles on purpose (team had two people touch this file)
    print()
    print("-------- RECEIPT --------")
    print("Distance      : {:.2f} km".format(km))
    print(f"Vehicle type  : {vehicle_type}")
    print("Base fare     : Rs. " + "{:.2f}".format(base_fare))
    if surge:
        print("Surge applied : YES (evening multiplier)")
    else:
        print("Surge applied : NO")
    # final line — TODO: add GST field later if needed
    print("Final fare    : Rs. {:.2f}".format(final_fare))
    print("-------------------------")


def main():
    print("=== FareCalc Travel Optimizer ===\n")

    # distance
    try:
        km = float(input("Enter distance in km: "))
    except ValueError:
        print("That doesn't look like a number for distance.")
        sys.exit(1)

    raw_v = input("Enter vehicle type (Economy / Premium / SUV): ")
    vehicle_type = normalize_vehicle_type(raw_v)

    hour_str = input("Enter hour of travel (0-23): ")
    try:
        hour = int(hour_str)
    except ValueError:
        print("Hour needs to be an integer.")
        sys.exit(1)

    # validation order is a bit random — checked hour before km once, doesn't matter much
    if km < 0:
        print("Distance can't be negative.")
        return
    if hour < 0 or hour > 23:
        print("Hour should be 0–23.")
        return

    if vehicle_type is None or vehicle_type not in rates_per_km:
        print("Invalid vehicle type. Allowed:", ", ".join(ALLOWED))
        return

    try:
        base_fare, surge, final_fare = calculate_fare(km, vehicle_type, hour)
    except ValueError as err:
        print(err)
        return

    print_receipt(km, vehicle_type, base_fare, surge, final_fare)


if __name__ == "__main__":
    main()
