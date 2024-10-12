-- CreateEnum
CREATE TYPE "user_role" AS ENUM ('admin', 'user');

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "user_name" VARCHAR(50) NOT NULL,
    "password" VARCHAR(50) NOT NULL,
    "nickname" VARCHAR(50) NOT NULL,
    "role" "user_role" NOT NULL DEFAULT 'user',
    "balance" MONEY NOT NULL DEFAULT 0,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "basket" (
    "id" SERIAL NOT NULL,
    "total_price" MONEY NOT NULL DEFAULT 0,
    "user_id" INTEGER NOT NULL,

    CONSTRAINT "basket_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "price" MONEY NOT NULL DEFAULT 0,
    "image" TEXT,
    "features" JSONB NOT NULL,
    "product_id" INTEGER NOT NULL,
    "basket_id" INTEGER,

    CONSTRAINT "product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_info" (
    "id" SERIAL NOT NULL,
    "description" TEXT,
    "productId" INTEGER,

    CONSTRAINT "product_info_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "review" (
    "id" SERIAL NOT NULL,
    "message" TEXT NOT NULL,
    "estimation" SMALLINT NOT NULL DEFAULT 0,
    "date_time" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userId" INTEGER,

    CONSTRAINT "review_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_id_key" ON "user"("id");

-- CreateIndex
CREATE UNIQUE INDEX "user_user_name_key" ON "user"("user_name");

-- CreateIndex
CREATE UNIQUE INDEX "basket_id_key" ON "basket"("id");

-- CreateIndex
CREATE UNIQUE INDEX "basket_user_id_key" ON "basket"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "product_id_key" ON "product"("id");

-- CreateIndex
CREATE UNIQUE INDEX "product_product_id_key" ON "product"("product_id");

-- CreateIndex
CREATE UNIQUE INDEX "product_info_id_key" ON "product_info"("id");

-- CreateIndex
CREATE UNIQUE INDEX "review_id_key" ON "review"("id");

-- AddForeignKey
ALTER TABLE "basket" ADD CONSTRAINT "basket_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product" ADD CONSTRAINT "product_basket_id_fkey" FOREIGN KEY ("basket_id") REFERENCES "basket"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "product_info" ADD CONSTRAINT "product_info_productId_fkey" FOREIGN KEY ("productId") REFERENCES "product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "review" ADD CONSTRAINT "review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "user"("id") ON DELETE SET NULL ON UPDATE CASCADE;
