class Main {
	static function main() {
		final count = 3;
		final text = 'é ${"value:" + '${count + 1}'}';
		if (text != "é value:4") throw text;
	}
}
