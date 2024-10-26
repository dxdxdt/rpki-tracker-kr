all: README.md result.csv result6.csv

README.md: table.md table6.md
	./produce-readme table.md table6.md < README.skel.md > README.md.tmp
	mv README.md.tmp README.md

.PHONY: clean

clean:
	rm -f \
		*.tmp \
		aslist \
		routelist \
		route6list \
		rpki-enabled \
		rpki6-enabled \
		table.md \
		table6.md \
		result.csv \
		result6.csv \
		README.md

aslist:
	curl -sS 'https://krnic.kisa.or.kr/jsp/business/management/asList.jsp' | \
		./get-kisa-as-list > aslist.tmp
	mv aslist.tmp aslist

routelist: aslist
	./query-prefixes < aslist > routelist.tmp
	mv routelist.tmp routelist
route6list: aslist
	./query-prefixes -6 < aslist > route6list.tmp
	mv route6list.tmp route6list

rpki-enabled: routelist
	./query-rpki-prefixes < routelist > rpki-enabled.tmp
	mv rpki-enabled.tmp rpki-enabled
rpki6-enabled: route6list
	./query-rpki-prefixes < route6list > rpki6-enabled.tmp
	mv rpki6-enabled.tmp rpki6-enabled

table.md: aslist routelist rpki-enabled
	./produce-table aslist routelist rpki-enabled > table.md.tmp
	mv table.md.tmp table.md
table6.md: aslist route6list rpki6-enabled
	./produce-table aslist route6list rpki6-enabled > table6.md.tmp
	mv table6.md.tmp table6.md

result.csv: aslist routelist rpki-enabled
	./produce-table -c aslist routelist rpki-enabled > result.csv.tmp
	mv result.csv.tmp result.csv
result6.csv: aslist route6list rpki6-enabled
	./produce-table -c aslist route6list rpki6-enabled > result6.csv.tmp
	mv result6.csv.tmp result6.csv
