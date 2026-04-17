# FareCalc Travel Optimizer

This is a small Python program that estimates how much you might pay for a cab or ride based on **distance**, **type of vehicle**, and **what time** you travel.

Evening hours (5 PM to 8 PM) use **surge pricing** — the fare is multiplied by 1.5 because demand is usually higher.

## What you need

- Python 3 installed on your computer (any recent version is fine).

## How to run

1. Open a terminal in this folder.
2. Run:

```bash
python main.py
```

3. Type the values when asked (distance, vehicle type, hour).

## How it works (simple)

- **Economy**, **Premium**, and **SUV** each have a different rate per kilometre (stored in a dictionary).
- The program multiplies distance × rate to get the **base fare**.
- If the hour is between **17 and 20** (inclusive), **surge** is applied and the final amount is 1.5 times the base fare.
- If you type a wrong vehicle name, the program shows an error message.

## Sample input / output

**Input**

```
Enter distance in km: 10
Enter vehicle type (Economy / Premium / SUV): Premium
Enter hour of travel (0-23): 18
```

**Output (example)**

```
=== FareCalc Travel Optimizer ===

-------- RECEIPT --------
Distance      : 10.00 km
Vehicle type  : Premium
Base fare     : Rs. 180.00
Surge applied : YES (1.5x evening rate)
Final fare    : Rs. 270.00
-------------------------
```

Another example **without** surge (morning):

```
Enter distance in km: 8
Enter vehicle type (Economy / Premium / SUV): Economy
Enter hour of travel (0-23): 9
```

You should see **Surge applied : NO** and final fare = 8 × 12 = **Rs. 96.00**.
