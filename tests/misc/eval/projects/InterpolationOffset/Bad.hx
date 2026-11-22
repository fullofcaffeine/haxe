class Bad {
    static function main() {
        final expression = 'é ${"value:" + '${missingValue}'}';
    }
}
