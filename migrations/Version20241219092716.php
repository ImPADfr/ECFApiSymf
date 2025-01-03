<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241219092716 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE categories (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE categories_movies (categories_id INT NOT NULL, movies_id INT NOT NULL, INDEX IDX_CE77D308A21214B7 (categories_id), INDEX IDX_CE77D30853F590A4 (movies_id), PRIMARY KEY(categories_id, movies_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE movies (id INT AUTO_INCREMENT NOT NULL, title VARCHAR(255) NOT NULL, resume VARCHAR(255) NOT NULL, date_sortie DATETIME NOT NULL, realisateur VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE categories_movies ADD CONSTRAINT FK_CE77D308A21214B7 FOREIGN KEY (categories_id) REFERENCES categories (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE categories_movies ADD CONSTRAINT FK_CE77D30853F590A4 FOREIGN KEY (movies_id) REFERENCES movies (id) ON DELETE CASCADE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE categories_movies DROP FOREIGN KEY FK_CE77D308A21214B7');
        $this->addSql('ALTER TABLE categories_movies DROP FOREIGN KEY FK_CE77D30853F590A4');
        $this->addSql('DROP TABLE categories');
        $this->addSql('DROP TABLE categories_movies');
        $this->addSql('DROP TABLE movies');
    }
}
