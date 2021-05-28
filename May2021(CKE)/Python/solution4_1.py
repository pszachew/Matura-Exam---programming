import pandas as pd


def przesun(word, letter):
    ls = list(word)
    if word.count(letter) == 0:
        return word
    if letter == 'Z':
        ls[word.index(letter)] = 'A'
        return "".join(ls)
    ls[word.index(letter)] = chr((ord(word[word.index(letter)])+1))
    return "".join(ls)


f = open("Wyniki4.txt", "a")
data = pd.read_csv("instrukcje.txt", names=['operation', 'obj'], sep=" ")
# 4_1
cnt = data[data['operation'] == 'DOPISZ']['operation'].count() - data[data['operation'] == 'USUN']['operation'] .count()
# f.write("4_1:\n dlugosc: {}".format(cnt))

# 4_2
z = 1
op_max = " "
z_max = 1
for i in range(data['operation'].size-1):
    if data['operation'][i] == data['operation'][i+1]:
        z = z+1
        if z > z_max:
            z_max = z
            op_max = data['operation'][i]
    else:
        z = 1

#f.write("\n 4_2: \noperacja:{} dlugosc:{}".format(op_max, z_max))

# 4_3
aggr = data[data['operation'] == 'DOPISZ'].groupby('obj').count()
aggr.columns = ['cnt']
aggr.sort_values(by='cnt', inplace=True, ascending=False)
#f.write("\n4_3\nletter: {} count: {}".format(aggr.index.values[0],aggr['cnt'][0]))

# 4_4
ans = ""
for i in range(data['obj'].size):
    if data['operation'][i] == 'DOPISZ':
        ans = ans + data['obj'][i]
    elif data['operation'][i] == 'USUN':
        ans = ans[:-1]
    elif data['operation'][i] == 'ZMIEN':
        ans = ans[:-1]
        ans = ans + data['obj'][i]
    elif data['operation'][i] == 'PRZESUN':
        ans = przesun(ans, data['obj'][i])

print(ans)




