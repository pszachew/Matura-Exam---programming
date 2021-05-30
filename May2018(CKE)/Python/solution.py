import pandas as pd


def distance(x):
    #ls = sorted(x)
    ls = list(x)
    ls.sort()
    if abs(ord(ls[0])-ord(ls[len(x)-1])) <= 10:
        return True
    else:
        return False


data = pd.read_csv("sygnaly.txt", sep=" ", names=["signal"])
# 4_1
s = ""
for i in range(39, data['signal'].size, 40):
    s = s + list(data['signal'][i])[9]

# 4_2
new_series = data['signal'].apply(lambda x: len(set(x)))
print(data['signal'][new_series.idxmax()])
print(new_series.max())

# 4_3
result = []
for x in data['signal'].items():
    if distance(x[1]):
        result.append(x[1])

print(result)
